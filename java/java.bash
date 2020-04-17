if [ -d "/usr/libexec/java_home" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

alias mvn='docker run -it --rm -e AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID -v "$HOME/.m2":/root/.m2 -v $PWD:/src -w /src maven:3.3-jdk-8 mvn'
