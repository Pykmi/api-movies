/* eslint-disable @typescript-eslint/no-unsafe-call */
import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsString,
  IsInt,
  Min,
  Max,
  IsOptional,
  ValidateNested,
} from 'class-validator';

export class CreatePersonDto {
  @ApiProperty()
  @IsString()
  firstName: string;

  @ApiProperty()
  @IsString()
  lastName: string;
}

export class CreateMovieDto {
  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsInt()
  year: number;

  @ApiProperty()
  @IsInt()
  @Min(0)
  @Max(18)
  ageLimit: number;

  @ApiProperty()
  @IsInt()
  @Min(1)
  @Max(5)
  rating: number;

  @ApiProperty()
  @IsString()
  @IsOptional()
  synopsis?: string;

  @ApiProperty({ type: CreatePersonDto })
  @ValidateNested()
  @Type(() => CreatePersonDto)
  director: CreatePersonDto;

  @ApiProperty({ type: [CreatePersonDto] })
  @ValidateNested({ each: true })
  @Type(() => CreatePersonDto)
  actors: CreatePersonDto[];
}
