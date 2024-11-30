import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

packages = [
    "requests",
    "beautifulsoup4",
]

for package in packages:
    install(package)
    print(f"{package} instalado com sucesso.")
