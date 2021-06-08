import sys
import semver
MLIFE_VERSION=sys.argv[1]

version = semver.VersionInfo.parse(MLIFE_VERSION)
