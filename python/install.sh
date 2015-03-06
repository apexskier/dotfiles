if ! command -v mkvirtualenv >/dev/null 2>&1
then
    echo "  Installing pip/virtualenv..."
    easy_install -U pip > /dev/null
    pip install virtualenv > /dev/null
    pip install virtualenvwrapper > /dev/null
fi
