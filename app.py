from flask import Flask, request, jsonify
import re
import json # Import json for handling JSON operations
import newrelic.agent
# Initialize New Relic agent
newrelic.agent.initialize('/Users/sathyanarayanan/Desktop/newrelic-1.ini') # Update this
with the actual path to your .ini file
app = Flask(__name__)
# Validate if the IP address is a valid IPv4 address
def is_valid_ip(ip):
regex = r'^(\d{1,3}\.){3}\d{1,3}$'
return re.match(regex, ip) is not None
# Validate incoming payload
@app.route('/validate', methods=['POST'])
def validate():
data = request.json
# Validation logic for 'ts'
if not data.get('ts'):
return jsonify({
"error": "Missing 'ts' field",
"guidance": "'ts' is required and must be a non-empty string (e.g., '1530228282')."
}), 400
if not isinstance(data['ts'], str):
return jsonify({
"error": "Invalid 'ts' field",
"guidance": "'ts' must be a string (e.g., '1530228282')."
}), 400
# Validation logic for 'sender'
if not data.get('sender'):
return jsonify({
"error": "Missing 'sender' field",
"guidance": "'sender' is required and must be a non-empty string (e.g.,
'user@example.com')."
}), 400
if not isinstance(data['sender'], str):
return jsonify({
"error": "Invalid 'sender' field",
"guidance": "'sender' must be a string (e.g., 'user@example.com')."
}), 400
# Validation logic for 'message'
if not data.get('message'):
return jsonify({
"error": "Missing 'message' field",
"guidance": "'message' is required and must be a non-empty JSON object (e.g., {'foo':
'bar'})."
}), 400
if not isinstance(data['message'], dict):
return jsonify({
"error": "Invalid 'message' field",
"guidance": "'message' must be a JSON object (e.g., {'foo': 'bar'})."
}), 400
if not data['message']:
return jsonify({
"error": "Empty 'message' field",
"guidance": "'message' must have at least one key-value pair (e.g., {'foo': 'bar'})."
}), 400
# Validation logic for 'sent-from-ip'
if 'sent-from-ip' in data and not is_valid_ip(data['sent-from-ip']):
return jsonify({
"error": "Invalid 'sent-from-ip' field",
"guidance": "'sent-from-ip' must be a valid IPv4 address (e.g., '192.168.0.1')."
}), 400
# Simulating message queue (or logging)
print("Valid payload received:", data)
# Store the validated payload locally
try:
with open('validated_payloads.json', 'a') as f:
f.write(json.dumps(data) + '\n')
except Exception as e:
return jsonify({"error": f"Failed to store payload locally: {str(e)}"}), 500
return jsonify({"message": "Payload validated successfully"}), 200
if __name__ == '__main__':
app.run(host='0.0.0.0', port=5003) # Flask will run on port 5003
