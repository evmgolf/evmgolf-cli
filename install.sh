#!/usr/bin/env bash
set -e

EVMGOLF_DIR=${EVMGOLF_DIR-"$HOME/.evmgolf"}
EVMGOLF_BIN_DIR="$EVMGOLF_DIR/bin"

main () {
  if [ ! -d $EVMGOLF_DIR ]; then 
    mkdir $EVMGOLF_DIR
  fi
  if [ ! -d $EVMGOLF_BIN_DIR ]; then 
    mkdir $EVMGOLF_BIN_DIR
  fi

  # curl https://raw.githubusercontent.com/evmgolf/evmgolf-cli/master/evmgolf > $EVMGOLF_BIN_DIR/evmgolf 
  cp ~evmgolf/evmgolf-cli/evmgolf $EVMGOLF_BIN_DIR/evmgolf 
  chmod +x $EVMGOLF_BIN_DIR/evmgolf

  case $SHELL in
  */zsh)
      PROFILE=$HOME/.zshrc
      PREF_SHELL=zsh
      ;;
  */bash)
      PROFILE=$HOME/.bashrc
      PREF_SHELL=bash
      ;;
  */fish)
      PROFILE=$HOME/.config/fish/config.fish
      PREF_SHELL=fish
      ;;
  *)
      echo "evmgolf: could not detect shell, manually add ${EVMGOLF_BIN_DIR} to your PATH."
      exit 1
  esac

  if [[ ":$PATH:" != *":${EVMGOLF_BIN_DIR}:"* ]]; then
      echo >> $PROFILE && echo "export PATH=\"\$PATH:$EVMGOLF_BIN_DIR\"" >> $PROFILE
  fi
}

main "$@" || exit 1
