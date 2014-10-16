if ! hash mkvirtualenv
then
    echo "  Installing pip/virtualenv..."
    easy_install -U pip > /dev/null
    pip install virtualenv > /dev/null
    pip install virtualenvwrapper > /dev/null
fi
