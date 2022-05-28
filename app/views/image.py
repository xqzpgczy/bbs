import os
from flask import Blueprint,send_from_directory, request, url_for
from flask_ckeditor import upload_success, upload_fail


blueprint = Blueprint('images', __name__, url_prefix="/images")

image_path = 'static/images/uploaded'

@blueprint.route('/', methods=['GET', 'POST'])
def index():
    return "wwwww"

@blueprint.route('/files/<path:filename>')
def uploaded_files(filename):
    path = image_path
    return send_from_directory(path, filename)

@blueprint.route('/upload', methods=['POST','GET'])
def upload():
    f = request.files.get('upload')  # 获取上传图片文件对象
    # Add more validations here
    extension = f.filename.split('.')[1].lower()
    if extension not in ['jpg', 'gif', 'png', 'jpeg']:  # 验证文件类型示例
        return upload_fail(message='Image only!')  # 返回upload_fail调用
    f.save(os.path.join(os.getcwd(), "app", image_path, f.filename))
    url = url_for('images.uploaded_files', filename=f.filename)
    return upload_success(url=url) # 返回upload_success调用