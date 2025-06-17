import pathlib
import os

__here__ = pathlib.Path(__file__).parent
BASE_DIR = __here__.parent
HOME = pathlib.Path(os.environ['HOME']).resolve()

print("🔗 Creating symlinks...")

def symlink(root, p):
    source = root / p
    base = (HOME / root.relative_to(BASE_DIR)).resolve()
    target = base /p.stem

    if not base.exists():
        os.makedirs(base)
    if not target.exists():
        print("Linking %s to %s" % (source, target))
        os.symlink(source, target)


def link_files():
    for root, dirs, files in os.walk(BASE_DIR):
        root = pathlib.Path(root)
        if ".git" in dirs:
            dirs.remove(".git")
        for d in tuple(d for d in dirs if not d == ".git"):
            d = pathlib.Path(d)
            if d.suffix == ".symlink":
                symlink(root, d)
        for f in files:
            f = pathlib.Path(f)
            if f.suffix == ".symlink":
                symlink(root, f)


if __name__ == '__main__':
    link_files()
    print("✅ Symlinks created successfully")

