import os

__here__ = __here__ = os.path.dirname(__file__)

def link_files():
    for root, dirs, files in os.walk(__here__):
        for d in list(dirs):
            if d.endswith(".symlink"):
                symlink_dir(d)
                dirs.remove(d)
        for f in files:
            if f.endswith(".symlink"):
                symlink_file(f)
        pass


