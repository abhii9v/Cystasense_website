"""
Content Moderation System for CystaSense Community Forum
Detects inappropriate content and suggests alternatives
"""

# List of inappropriate words to filter (can be expanded)
INAPPROPRIATE_WORDS = {
    # Profanity and vulgar terms
    'damn', 'hell', 'crap', 'stupid', 'idiot', 'dumb', 'moron', 'fool',
    'jerk', 'ass', 'bastard', 'bitch', 'shit', 'fuck', 'fucking',
    
    # Offensive/discriminatory terms
    'fat', 'ugly', 'worthless', 'loser', 'failure', 'pathetic',
    
    # Stigmatizing substance use terms
    'junkie', 'addict', 'alcoholic', 'drunk', 'user', 'abuser',
    'drug abuser', 'substance abuser', 'former addict', 'reformed addict',
}

# Suggested alternatives for common inappropriate words
WORD_ALTERNATIVES = {
    'stupid': 'unwise, not helpful, confusing',
    'idiot': 'person, individual, someone',
    'dumb': 'unclear, confusing, not well thought out',
    'moron': 'person who may not understand',
    'fat': 'plus-size, curvy, larger body',
    'ugly': 'different appearance, unique look',
    'worthless': 'struggling, going through challenges',
    'loser': 'person facing difficulties',
    'failure': 'learning experience, setback',
    'pathetic': 'unfortunate, challenging',
    'damn': 'darn, frustrating',
    'hell': 'difficult situation, tough time',
    'crap': 'not great, disappointing',
    'jerk': 'unkind person, difficult person',
    'bitch': 'difficult person, unkind individual',
    'ass': 'rude person, difficult individual',
    'bastard': 'unkind person',
    
    # Person-first language for substance use
    'junkie': 'person in active use, person with substance use disorder',
    'addict': 'person with substance use disorder',
    'alcoholic': 'person with alcohol use disorder',
    'drunk': 'person who misuses alcohol, person engaging in unhealthy alcohol use',
    'user': 'person with opioid use disorder, person in active use',
    'abuser': 'person in active use, person with substance use disorder',
    'drug abuser': 'person with substance use disorder, person in active use',
    'substance abuser': 'person with substance use disorder, person in active use',
    'former addict': 'person in recovery, person in long-term recovery',
    'reformed addict': 'person who previously used drugs, person in recovery',
}

def check_content(text):
    """
    Check if content contains inappropriate words
    
    Returns:
        dict: {
            'is_appropriate': bool,
            'flagged_words': list,
            'suggestions': dict
        }
    """
    if not text:
        return {'is_appropriate': True, 'flagged_words': [], 'suggestions': {}}
    
    text_lower = text.lower()
    flagged_words = []
    suggestions = {}
    
    for word in INAPPROPRIATE_WORDS:
        # Check for whole word matches (not just substrings)
        import re
        pattern = r'\b' + re.escape(word) + r'\b'
        if re.search(pattern, text_lower, re.IGNORECASE):
            flagged_words.append(word)
            if word in WORD_ALTERNATIVES:
                suggestions[word] = WORD_ALTERNATIVES[word]
    
    return {
        'is_appropriate': len(flagged_words) == 0,
        'flagged_words': flagged_words,
        'suggestions': suggestions
    }

def get_moderation_message(flagged_words, suggestions):
    """
    Generate a helpful moderation message
    """
    message = "⚠️ Your post contains language that may not align with our community guidelines. "
    message += "CystaSense is a supportive community for people managing PCOS. "
    message += "Please consider using more respectful and supportive language.\n\n"
    
    if suggestions:
        message += "📝 Suggested alternatives:\n"
        for word, alternatives in suggestions.items():
            message += f"• Instead of '{word}', try: {alternatives}\n"
    
    message += "\nPlease edit your message and try again. Thank you for keeping our community kind and supportive! 💜"
    
    return message
