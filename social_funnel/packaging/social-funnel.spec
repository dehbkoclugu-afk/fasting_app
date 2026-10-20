from pathlib import Path

from PyInstaller.utils.hooks import collect_submodules


ENTRY_POINT = "social_funnel.windows.launcher:launch"
RUNTIME_FONT = "C:/Windows/Fonts/segoeui.ttf"

project_root = Path(SPECPATH).resolve().parent
source_root = project_root / "src"
entry_script = source_root / "social_funnel" / "windows" / "launcher.py"

data_specs = (
    ("src/social_funnel/web/templates", "social_funnel/web/templates"),
    ("src/social_funnel/web/static", "social_funnel/web/static"),
    ("src/social_funnel/storage/schema.sql", "social_funnel/storage"),
    ("content/fasttrack-30-day-launch.json", "content"),
    ("assets/artwork", "assets/artwork"),
)
datas = [(str(project_root / source), target) for source, target in data_specs]

analysis = Analysis(
    [str(entry_script)],
    pathex=[str(source_root)],
    binaries=[],
    datas=datas,
    hiddenimports=(
        collect_submodules("uvicorn")
        + collect_submodules("keyring.backends")
        + ["jinja2.ext", "starlette.middleware.sessions"]
    ),
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=["boto3", "botocore"],
    noarchive=False,
)
pyz = PYZ(analysis.pure)

exe = EXE(
    pyz,
    analysis.scripts,
    [],
    exclude_binaries=True,
    name="FastTrack Social Funnel",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
)

collection = COLLECT(
    exe,
    analysis.binaries,
    analysis.datas,
    strip=False,
    upx=True,
    name="FastTrack Social Funnel",
)
