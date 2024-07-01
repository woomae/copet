import { BadRequestException } from '@nestjs/common';

const catList = ['일상', '도움', 'Q&A', '정보&후기'];
export function categoryChecker(category: string) {
  if (!catList.includes(category)) {
    throw new BadRequestException('category not found');
  }
}
