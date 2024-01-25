git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8
cd "D://KD8116/git"
git init
git add --renormalize .
git commit -m "KD"
git remote remove origin
git remote add origin https://KirillovItstep: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@github.com/KirillovItstep/KD8116.git
git push --set-upstream origin master
