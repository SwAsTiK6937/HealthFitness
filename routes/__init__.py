from flask import Flask
from .iot_routes import iot_bp
from routes.auth_routes import auth_bp
from routes.food_routes import food_bp
from routes.iot_routes import iot_bp
from routes.exercise_routes import exercise_bp
from .exercise_routes import exercise_bp


def create_app():
    app = Flask(__name__)
    app.config.from_object('config')

    # Register Blueprints
    app.register_blueprint(auth_bp, url_prefix='/auth')
    app.register_blueprint(food_bp, url_prefix='/food')
    app.register_blueprint(iot_bp, url_prefix='/iot')
    app.register_blueprint(exercise_bp, url_prefix='/exercise')

    return app
