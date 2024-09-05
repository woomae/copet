import { Controller, Post, Query, UseGuards } from '@nestjs/common';
import { ChatbotService } from './chatbot.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';

@Controller({ path: 'chatbot', version: '1' })
export class ChatbotController {
  constructor(private readonly chatbotService: ChatbotService) {}

  @UseGuards(JwtAuthGuard)
  @Post('')
  async getChatbotResponse(@Query('message') message: string) {
    const result = await this.chatbotService.getChatbotResponse(message);
    return result;
  }
}
