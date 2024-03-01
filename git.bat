
cd "D://KD8116/git"
git init
git add .
git commit -m "KD"
git remote remove origin
git remote add origin https://KirillovItstep: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@github.com/KirillovItstep/KD8116.git
git push --set-upstream origin master


Get-ChildItem *.m -Recurse | ForEach-Object {
$content = $_ | Get-Content

Set-Content -PassThru $_.Fullname $content -Encoding UTF8 -Force}