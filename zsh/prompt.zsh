autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}
git_stuff() {
  if $($git status -s &> /dev/null)
  then
    echo -n "(±"
    if [[ $($git status --porcelain) == "" ]]
    then
      echo -n "%{$fg[white]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo -n "%{$fg_bold[white]%}$(git_prompt_info)%{$reset_color%}"
    fi
    echo -n "$(need_push)"
    echo ") "
  fi
}
git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  # echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
  echo "${ref#refs/heads/}"
}
unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo " %{$fg[white]%}unpushed%{$reset_color%}"
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

virtualenv() {
  if [[ -n "$VIRTUAL_ENV" ]]
  then
    echo="(⊙${VIRTUAL_ENV#$WORKON_HOME/}) "
  fi
}
NEWLINE=$'\n'

cmd_info() {
  if [[ "$?" != "0" ]]
  then
    echo "%{$fg_bold[red]%}%?↩%{$reset_color%} "
  fi
  # echo "%{$fg_bold[red]%}$(runtime)%{$reset_color%} "
}

username="%{$fg[cyan]%}%n%{$reset_color%}"
hostname="%{$fg[green]%}%m%{$reset_color%}"
rw() {
  if [[ -w "$PWD" ]]
  then
    echo "%{$fg[green]%}:%{$reset_color%}"
  else
    echo "%{$fg[red]%}:%{$reset_color%}"
  fi
}
directory() {
  echo "%{$fg[yellow]%}%~%{$reset_color%}"
}

mark="@"
# If we are connected with a X11 support
if [[ -n "$DISPLAY" ]] ; then
    mark="%{$fg_bold[white]%}$mark$reset_color"
else
    mark="%{$fg[white]%}$mark$reset_color"
fi

export PROMPT=$'$(cmd_info)${username}${mark}$(rb_prompt)${hostname}$(rw)$(directory) $(virtualenv)$(git_stuff)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}
