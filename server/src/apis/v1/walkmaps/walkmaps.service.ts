import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { WalkmapsRepository } from './walkmaps.repository';
import { Photos } from '../photos/photos.entity';
import { Repository } from 'typeorm';
import { CreateWalkmapDto } from 'src/dto/create-walkmap.dto';
import { Walkmaps } from './walkmaps.entity';
import { UsersRepository } from '../users/users.repository';
import { prune } from 'src/libs/utils';
import { PhotosService } from '../photos/photos.service';
import { CreatePhotoDto } from 'src/dto/create-photo.dto';

@Injectable()
export class WalkmapsService {
  constructor(
    private readonly photosService: PhotosService,
    @InjectRepository(WalkmapsRepository)
    private readonly walkmapsRepository: WalkmapsRepository,
    @InjectRepository(Photos)
    private readonly photosRepository: Repository<Photos>,
  ) {}
  async createWalkmap(
    id: number,
    createWalkmapDto: CreateWalkmapDto,
    file: { mapimg: Express.Multer.File[] },
  ): Promise<Walkmaps> {
    const walkmap = new Walkmaps();
    Object.assign(walkmap, prune(createWalkmapDto));
    walkmap.owner_id = id;
    const img_url = await this.photosService.uploadFiles(
      file.mapimg,
      '/walkmaps',
    );
    const photo = new CreatePhotoDto();
    photo.img_path = img_url[0];
    photo.walkmap = walkmap;
    await this.photosRepository.save(photo);

    const walkmap_id = (await this.walkmapsRepository.save(walkmap))._id;
    //아래 findOne은 추후 제거 필요
    return await this.walkmapsRepository.findOne({
      where: { _id: walkmap_id },
      relations: ['photo'],
    });
  }
  async getWalkmaps(id: number): Promise<Walkmaps[]> {
    return await this.walkmapsRepository.find({
      where: { owner_id: id },
      relations: ['photo'],
    });
  }
}
