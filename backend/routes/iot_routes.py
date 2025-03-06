from flask import Blueprint

iot_bp = Blueprint('iot', __name__)  # Make sure this line exists

@iot_bp.route('/iot-data')
def get_iot_data():
    return {"message": "IoT Data"}
