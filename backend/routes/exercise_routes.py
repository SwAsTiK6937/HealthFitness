from flask import Blueprint

exercise_bp = Blueprint('exercise', __name__)  # This line must exist

@exercise_bp.route('/exercise-data')
def get_exercise_data():
    return {"message": "Exercise Data"}
