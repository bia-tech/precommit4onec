pushd .git
md hooks
popd

mklink /D /H ".git/hooks/pre-commit" "%~dp0pre-commit"
mklink /D /H ".git/hooks/v8files-extractor.os" "%~dp0v8files-extractor.os"
mklink /J ".git/hooks/v8Reader" "%~dp0v8Reader"
mklink /J ".git/hooks/tools" "%~dp0tools"
git config --local core.quotepath false
