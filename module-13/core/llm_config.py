import os
from dotenv import load_dotenv
from crewai import LLM

load_dotenv()

# Centraliza a inteligência do projeto

# Chat GPT
nexus_llm = LLM(
    model="gpt-4o-mini",  # Ou "gpt-4o", "gpt-3.5-turbo"
    api_key=os.getenv("OPENAI_API_KEY"),
    temperature=0.2

# Groq - Não funcionou com CrewAI
# nexus_llm = LLM(
#     model="groq/llama-3.1-8b-instant",
#     api_key=os.getenv("GROQ_API_KEY"),
#     temperature=0.2,
#     cache=False
)