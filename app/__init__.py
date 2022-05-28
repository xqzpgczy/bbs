from flask import Flask
from flask_bootstrap import Bootstrap
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from flask_moment import Moment
from flask_pagedown import PageDown
from flask_mail import Mail
from config import config

bootstrap = Bootstrap()
db = SQLAlchemy()
moment = Moment()
pagedown = PageDown()
mail = Mail()

login_manager = LoginManager()
login_manager.login_view = 'auth.login'


def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])

    from flask_ckeditor import CKEditor
    app.config['CKEDITOR_FILE_UPLOADER'] = 'images.upload'
    ckeditor = CKEditor()
    ckeditor.init_app(app)


    if not app.config['DEBUG'] and not app.config['TESTING']:
        # configure logging for production

        # email errors to the administrators
        if app.config.get('MAIL_ERROR_RECIPIENT') is not None:
            import logging
            from logging.handlers import SMTPHandler
            credentials = None
            secure = None
            if app.config.get('MAIL_USERNAME') is not None:
                credentials = (app.config['MAIL_USERNAME'], app.config['MAIL_PASSWORD'])
                if app.config['MAIL_USE_TLS'] is not None:
                    secure = ()
            mail_handler = SMTPHandler(
                mailhost=(app.config['MAIL_SERVER'], app.config['MAIL_PORT']),
                fromaddr=app.config['MAIL_DEFAULT_SENDER'],
                toaddrs=[app.config['MAIL_ERROR_RECIPIENT']],
                subject='[Talks] Application Error',
                credentials=credentials,
                secure=secure)
            mail_handler.setLevel(logging.ERROR)
            app.logger.addHandler(mail_handler)

        # send standard logs to syslog
        import logging
        from logging.handlers import SysLogHandler
        syslog_handler = SysLogHandler()
        syslog_handler.setLevel(logging.WARNING)
        app.logger.addHandler(syslog_handler)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
    # app.config['BOOTSTRAP_SERVE_LOCAL'] = True

    bootstrap.init_app(app)
    db.init_app(app)
    moment.init_app(app)
    pagedown.init_app(app)
    mail.init_app(app)
    login_manager.init_app(app)


    from .posts import posts as posts_blueprint
    app.register_blueprint(posts_blueprint)

    from .tags import tag as tag_blueprint
    app.register_blueprint(tag_blueprint)

    from .messages import message as message_bluepring
    app.register_blueprint(message_bluepring)

    from .comments import comment as comment_blueprint
    app.register_blueprint(comment_blueprint)

    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint, url_prefix='/auth')

    from .api_1_0 import api as api_blueprint
    app.register_blueprint(api_blueprint, url_prefix='/api/1.0')

    from .views import image
    app.register_blueprint(image.blueprint)


    with app.app_context():
        db.create_all()

    # from app.emails import start_email_thread
    # @app.before_first_request
    # def before_first_request():
    #     start_email_thread()

    return app
