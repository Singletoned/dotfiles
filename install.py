import os

__here__ = __here__ = os.path.dirname(__file__)
HOME = os.environ['HOME']

def symlink(p):
    source = os.path.join(__here__, p)
    target = os.path.join(HOME, "."+p.split('.symlink')[0])
    if not os.path.exists(target):
        print(source, target)
        os.symlink(source, target)

def link_files():
    for root, dirs, files in os.walk(__here__):
        if ".git" in dirs:
            dirs.remove(".git")
        print(root, dirs, files)
        for d in list(dirs):
            if d.endswith(".symlink"):
                symlink(d)
                dirs.remove(d)
        for f in files:
            if f.endswith(".symlink"):
                symlink(f)

if __name__ == '__main__':
    link_files()
