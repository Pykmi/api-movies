import { ApiProperty } from '@nestjs/swagger';

export class PersonDto {
  @ApiProperty()
  id: number;

  @ApiProperty()
  firstName: string;

  @ApiProperty()
  lastName: string;

  @ApiProperty({ enum: ['ACTOR', 'DIRECTOR'] })
  type: 'ACTOR' | 'DIRECTOR';
}

export class MovieDto {
  @ApiProperty()
  id: number;

  @ApiProperty()
  name: string;

  @ApiProperty()
  year: number;

  @ApiProperty()
  ageLimit: number;

  @ApiProperty()
  rating: number;

  @ApiProperty()
  synopsis: string;

  @ApiProperty({ type: PersonDto, nullable: true })
  director: PersonDto | null;

  @ApiProperty({ type: [PersonDto] })
  actors: PersonDto[];
}

export class ErrorResponse {
  @ApiProperty({ example: 503 })
  statusCode: number;

  @ApiProperty({ example: 'Service Unavailable' })
  message: string;
}
