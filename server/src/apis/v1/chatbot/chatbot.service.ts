import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import callchatbot from 'src/libs/chatbot/chatbot';

@Injectable()
export class ChatbotService {
  constructor(private readonly env: ConfigService) {}
  async getChatbotResponse(message: string): Promise<string> {
    const respones = await callchatbot(
      message,
      this.env.get<string>('GPT_API_KEY'),
    );
    return respones;
  }
}
