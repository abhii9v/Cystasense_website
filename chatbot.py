"""
PCOS Health Assistant Chatbot - Powered by OpenAI
"""
import os
import json
from datetime import datetime
from openai import OpenAI
from pcos_knowledge_base import get_pcos_context

client = OpenAI(
    api_key=os.environ.get("AI_INTEGRATIONS_OPENAI_API_KEY"),
    base_url=os.environ.get("AI_INTEGRATIONS_OPENAI_BASE_URL")
)

conversation_history = {}

def get_chat_response(user_message, user_id=None, conversation_id=None):
    """
    Get a response from the PCOS Health Assistant chatbot
    
    Args:
        user_message: The user's question or message
        user_id: Optional user ID for personalization
        conversation_id: Optional conversation ID to maintain context
    
    Returns:
        dict with 'response' and 'conversation_id'
    """
    if not conversation_id:
        conversation_id = f"{user_id or 'anonymous'}_{datetime.now().strftime('%Y%m%d%H%M%S')}"
    
    if conversation_id not in conversation_history:
        conversation_history[conversation_id] = []
    
    system_prompt = get_pcos_context()
    
    conversation_history[conversation_id].append({
        "role": "user",
        "content": user_message
    })
    
    if len(conversation_history[conversation_id]) > 20:
        conversation_history[conversation_id] = conversation_history[conversation_id][-20:]
    
    messages = [
        {"role": "system", "content": system_prompt}
    ] + conversation_history[conversation_id]
    
    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=1000,
            temperature=0.7
        )
        
        assistant_message = response.choices[0].message.content
        
        conversation_history[conversation_id].append({
            "role": "assistant",
            "content": assistant_message
        })
        
        return {
            "response": assistant_message,
            "conversation_id": conversation_id,
            "success": True
        }
        
    except Exception as e:
        error_message = f"I apologize, but I'm having trouble processing your request right now. Please try again in a moment. Error: {str(e)}"
        return {
            "response": error_message,
            "conversation_id": conversation_id,
            "success": False
        }


def get_quick_suggestions():
    """Return quick suggestion topics for the chat interface"""
    return [
        "What is PCOS?",
        "Common symptoms of PCOS",
        "Best foods for PCOS",
        "Exercise recommendations",
        "How to improve fertility with PCOS",
        "Managing PCOS weight",
        "PCOS and mental health",
        "Treatment options for PCOS"
    ]


def clear_conversation(conversation_id):
    """Clear a specific conversation history"""
    if conversation_id in conversation_history:
        del conversation_history[conversation_id]
        return True
    return False


def get_conversation_history(conversation_id):
    """Get the conversation history for a specific conversation ID"""
    if conversation_id and conversation_id in conversation_history:
        return conversation_history[conversation_id]
    return []
