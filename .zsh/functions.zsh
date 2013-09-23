# make gif image from .mov file

gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}


# clones a repository, cds into it, and opens it in my editor.
# - arg 1 - url|username|repo remote endpoint, username on github, or name of
#           repository.
# - arg 2 - (optional) name of repo
#
# usage:
#   $ clone things
#     .. git clone git@github.com:stephenplusplus/things.git things
#     .. cd things
#     .. subl .
#
#   $ clone git@github.com:stephenplusplus/dots.git
#     .. git clone git@github.com:stephenplusplus/dots.git dots
#     .. cd dots
#     .. subl .
#
#   $ clone yeoman generator
#     .. git clone git@github.com:yeoman/generator.git generator
#     .. cd generator
#     .. subl .

function clone {
  local url=$1;
  local repo=$2;

  if [[ ${url:0:4} == 'http' || ${url:0:3} == 'git' ]]
  then
    # just clone this thing.
    repo=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
  elif [[ -z $repo ]]
  then
    # my own stuff.
    repo=$url;
    url="git@github.com:stephenplusplus/$repo";
  else
    # not my own, but I know whose it is.
    url="git@github.com:$url/$repo.git";
  fi

  git clone $url $repo && cd $repo && subl .;
}

alias gh="open \`git remote -v | grep github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e 's/git@/http:\/\//'\`"
