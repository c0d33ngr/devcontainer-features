#!/bin/bash

set -eu

# Set default VERSION to 2 if not set
VERSION=${VERSION:-2}

# Check if VERSION is valid
case $VERSION in
  1|2) ;;
  *)
    echo "Error: Invalid VERSION value. Only 1 and 2 are supported."
    exit 1
    ;;
esac

# For version 2, check if Python version is 3.8+
if [ "$VERSION" = "2" ]; then
  if ! python3 --version | grep -q "3\.8\|3\.9\|3\.10\|3\.11"; then
    echo "Error: For version 2, Python version must be 3.8 or higher."
    exit 1
  fi
fi

case $VERSION in
  1)
    # Check if pip is installed
    if ! command -v pip3 &> /dev/null; then
      echo "Installing pip..."
      python3 -m ensurepip
    fi
    echo "Installing Cookiecutter version 1 using pip..."
    pip3 install cookiecutter
    ;;
  2)
    # Check if pipx is installed
    if command -v pipx &> /dev/null; then
      echo "Installing Cookiecutter Data Science version 2 using pipx..."
      pipx install cookiecutter-data-science
    elif command -v pip3 &> /dev/null; then
      echo "Warning: Recommended installation method is pipx, but using pip instead."
      echo "Installing Cookiecutter Data Science version 2 using pip..."
      pip3 install cookiecutter-data-science
    else
      echo "Installing pipx..."
      python3 -m pip install --user pipx
      echo "Installing Cookiecutter Data Science version 2 using pipx..."
      pipx install cookiecutter-data-science
    fi
    ;;
esac

echo "Installation complete!"
