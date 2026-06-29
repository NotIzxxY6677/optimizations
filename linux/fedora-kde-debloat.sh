#!/usr/bin/env bash
# =============================================================================
#  fedora-kde-debloat.sh   (Fedora 44 KDE)
#  Removes unused stock KDE/GNOME applications. Reviewed: nothing here is
#  required for networking, the Plasma session core, or boot/stability.
#  No -y — review the dnf transaction (and any CASCADED removals) before
#  confirming. Safe to re-run; already-absent packages are skipped.
# =============================================================================
set -euo pipefail

# Flagged for your decision (left in the list as you chose):
#   kleopatra          - GUI certificate / GPG key manager (gpg CLI remains)
#   plasma-discover    - GUI software centre / auto-updates (dnf remains)
#   gnome-disk-utility - GUI disk tool (install partitionmanager if wanted)
#   kjournald          - KDE systemd-JOURNAL VIEWER only; does NOT touch
#                        systemd-journald or kernel logging.

sudo dnf remove \
  abrt akregator digikam dragon elisa-player filelight gnome-disk-utility \
  k3b kaddressbook kcharselect kdebugsettings kde-connect kfind khelpcenter \
  kjournald kleopatra kmahjongg kmail kmines kmouth korganizer kpat krdc \
  krfb krusader ktorrent neochat plasma-welcome plasma-discover qrca skanpage
