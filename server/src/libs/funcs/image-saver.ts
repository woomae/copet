//deprecated
import * as fs from 'fs';
import * as path from 'path';

export class ImageSaver {
  async saveFilesToDisk(files: Express.Multer.File[]) {
    const uploadDir = path.join(__dirname, '..', 'uploads');
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    for (const file of files) {
      const filePath = path.join(uploadDir, file.originalname);
      fs.writeFileSync(filePath, file.buffer);
    }
  }
  // 업로드된 파일들의 경로를 문자열로 반환하는 메서드
  getImagePaths(files: Express.Multer.File[]): string {
    return files
      .map((file) => path.join(__dirname, '..', 'uploads', file.originalname))
      .join(',');
  }
}
