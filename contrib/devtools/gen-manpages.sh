#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

WAZZLED=${WAZZLED:-$BINDIR/wazzled}
WAZZLECLI=${WAZZLECLI:-$BINDIR/wazzle-cli}
WAZZLETX=${WAZZLETX:-$BINDIR/wazzle-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/wazzle-wallet}
WAZZLEQT=${WAZZLEQT:-$BINDIR/qt/wazzle-qt}

[ ! -x $WAZZLED ] && echo "$WAZZLED not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a BTCVER <<< "$($WAZZLECLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for wazzled if --version-string is not set,
# but has different outcomes for wazzle-qt and wazzle-cli.
echo "[COPYRIGHT]" > footer.h2m
$WAZZLED --version | sed -n '1!p' >> footer.h2m

for cmd in $WAZZLED $WAZZLECLI $WAZZLETX $WALLET_TOOL $WAZZLEQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
