#!/bin/sh
echo "  Installing pip/virtualenv..."
easy_install pip > /dev/null
pip install virtualenv > /dev/null
pip install virtualenvwrapper > /dev/null
