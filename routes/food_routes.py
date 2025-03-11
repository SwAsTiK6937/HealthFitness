from flask import Blueprint, request, jsonify
from models import db, FoodLog

food_bp = Blueprint('food', __name__)

@food_bp.route('/log', methods=['POST'])
def log_food():
    data = request.json
    new_log = FoodLog(user_id=data['user_id'], food_item=data['food_item'], calories=data['calories'],
                      protein=data['protein'], carbs=data['carbs'], fats=data['fats'], meal_type=data['meal_type'])
    db.session.add(new_log)
    db.session.commit()
    return jsonify({'message': 'Food logged successfully'})
