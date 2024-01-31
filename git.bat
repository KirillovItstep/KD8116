
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