# flask-demo
感谢： 本项目借鉴了 https://github.com/goalong/flask-demo.git 对此十分感谢



###使用说明

克隆项目：


git clone https://github.com/xqzpgczy/bbs.git


1 cd flask-demo

2 修改虚拟环境变量 文件 .env_bk 修改为 .env。    将其中的sql 换位你的sql
DATABASE_URL=mysql+pymysql://root:625124155@127.0.0.1:3306/flask_demo


3 在数据库中建立数据库 flask_demo   字符集选 支持中文的  utf8mb4
导入数据库文件  flask_demo.sql 进数据库 flask_demo




4. 
pip install pipenv  安装虚拟环境管理模块 
pipenv shell  # 创建虚拟环境 环境要求 python3.5以上 。 
如果环境不是python3.9 请修改 Pipfile 中的值为对应值 python_version = "3.9"

6. pip install -r requirements.txt  安装依赖

7. flask run 

8. 打开浏览器，在地址栏输入http://localhost:5000/
9. 当前直接在网页注册用户。 不需要任何验证


