fswatch -e ".*" -i "\\.dart$" . | xargs -n1 -I {} sh -c "echo $'\e[1;31m'{}$'\e[0m'; flutter test -j 2 ./test"
