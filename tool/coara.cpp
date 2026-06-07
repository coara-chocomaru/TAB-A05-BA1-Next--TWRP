#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <errno.h>
#include <fcntl.h>
#include <dirent.h>

struct PartitionEntry {
    const char* name;
    const char* block;
    const char* fstype;
    const char* mountpoint;
};

static const PartitionEntry PARTITIONS[] = {
    { "metadata", "/dev/block/by-name/metadata", "ext4", "/metadata" },
    { "factory",  "/dev/block/by-name/factory",  "ext4", "/factory"  },
    { "cache",    "/dev/block/by-name/cache",     "ext4", "/cache"    },
    { "data",     "/dev/block/by-name/userdata",  "f2fs", "/data"     },
    { nullptr,    nullptr,                         nullptr, nullptr   },
};

static int run_cmd(const char* cmd) {
    int ret = system(cmd);
    if (ret != 0) {
        fprintf(stderr, "[coara] FAILED: %s (exit=%d)\n", cmd, WEXITSTATUS(ret));
    }
    return WEXITSTATUS(ret);
}

static void force_umount(const char* mountpoint) {
    if (umount2(mountpoint, MNT_DETACH) == 0) {
        return;
    }
    if (errno == ENOENT || errno == EINVAL) {
        return;
    }
    char cmd[256];
    snprintf(cmd, sizeof(cmd), "umount -f '%s' 2>/dev/null", mountpoint);
    system(cmd);
}

static int wipe_block(const char* block) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd),
        "dd if=/dev/zero of='%s' bs=4096 count=512 2>/dev/null", block);
    return run_cmd(cmd);
}

static int format_ext4(const char* block, const char* label) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd),
        "mke2fs -t ext4 -b 4096 -L '%s' -F '%s'", label, block);
    return run_cmd(cmd);
}

static int format_f2fs(const char* block, const char* label) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd),
        "mkfs.f2fs -f -l '%s' '%s'", label, block);
    return run_cmd(cmd);
}

static int format_partition(const PartitionEntry* p) {
    printf("[coara] === %s (%s) ===\n", p->name, p->fstype);

    force_umount(p->mountpoint);
    printf("[coara] umount: %s\n", p->mountpoint);

    wipe_block(p->block);
    printf("[coara] wiped: %s\n", p->block);

    int ret;
    if (strcmp(p->fstype, "ext4") == 0) {
        ret = format_ext4(p->block, p->name);
    } else if (strcmp(p->fstype, "f2fs") == 0) {
        ret = format_f2fs(p->block, p->name);
    } else {
        fprintf(stderr, "[coara] unknown fstype: %s\n", p->fstype);
        return 1;
    }

    if (ret == 0) {
        printf("[coara] OK: %s\n", p->name);
    } else {
        fprintf(stderr, "[coara] FAILED: %s\n", p->name);
    }
    return ret;
}

static void usage(const char* argv0) {
    fprintf(stderr,
        "usage:\n"
        "  %s fix\n"
        "  %s metadata\n"
        "  %s factory\n"
        "  %s cache\n"
        "  %s data\n",
        argv0, argv0, argv0, argv0, argv0);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        usage(argv[0]);
        return 1;
    }

    const char* target = argv[1];

    if (strcmp(target, "fix") == 0) {
        int overall = 0;
        for (int i = 0; PARTITIONS[i].name != nullptr; i++) {
            int r = format_partition(&PARTITIONS[i]);
            if (r != 0) overall = r;
        }
        if (overall == 0) {
            printf("[coara] all partitions formatted successfully\n");
        } else {
            fprintf(stderr, "[coara] one or more partitions failed\n");
        }
        return overall;
    }

    for (int i = 0; PARTITIONS[i].name != nullptr; i++) {
        if (strcmp(target, PARTITIONS[i].name) == 0) {
            return format_partition(&PARTITIONS[i]);
        }
    }

    fprintf(stderr, "[coara] unknown target: %s\n", target);
    usage(argv[0]);
    return 1;
}
