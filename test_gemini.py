import google.generativeai as genai
import os

try:
    genai.configure() # Will use GOOGLE_API_KEY if exists or ADC
    model = genai.GenerativeModel('gemini-1.5-pro')
    response = model.generate_content("Hello!")
    print("SUCCESS:", response.text)
except Exception as e:
    print("FAILED:", e)
