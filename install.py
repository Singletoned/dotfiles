from __future__ import print_function

import os

__here__ = __here__ = os.path.abspath(os.path.dirname(__file__))
HOME = os.environ['HOME']


def symlink(root, p):
    base = os.path.join(HOME, "".join(root.split(__here__)).strip("/"))
    source = os.path.join(root, p)
    target = os.path.join(base, "."+p.split('.symlink')[0])
    if not os.path.exists(base):
        os.makedirs(base)
    if not os.path.exists(target):
        print("Linking %s to %s" % (source, target))
        os.symlink(source, target)


def link_files():
    for root, dirs, files in os.walk(__here__):
        if ".git" in dirs:
            dirs.remove(".git")
        for d in list(dirs):
            if d.endswith(".symlink"):
                symlink(root, d)
                dirs.remove(d)
        for f in files:
            if f.endswith(".symlink"):
                symlink(root, f)


if __name__ == '__main__':
    link_files()
