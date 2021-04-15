title GIT提交批处理——holden

color 20

echo 开始提交代码到本地仓库

echo 当前目录是：%cd%

echo 开始添加变更


git add -A .


echo 提交变更到本地仓库


git commit -m "index"



echo 将变更情况提交到远程github服务器



git push github master


echo 将变更情况提交到远程gitee服务器


git push gitee master



echo 批处理执行完毕！



pause
