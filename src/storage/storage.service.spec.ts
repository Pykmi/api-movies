import { movies, people } from '../config/schema';
import { StorageService } from './storage.service';
import { NodePgDatabase } from 'drizzle-orm/node-postgres';

import * as schema from '../config/schema';

type MockQuery = {
  from: jest.Mock;
  where: jest.Mock;
  innerJoin: jest.Mock;
  leftJoin: jest.Mock;
  values: jest.Mock;
  returning: jest.Mock;
};

type MockStorage = {
  select: jest.Mock<MockQuery, []>;
  insert: jest.Mock<MockQuery, []>;
};

describe('StorageService', () => {
  let service: StorageService;
  let mockStorage: MockStorage;
  let mockQuery: MockQuery;

  beforeEach(() => {
    mockQuery = {
      from: jest.fn().mockReturnThis(),
      where: jest.fn().mockReturnThis(),
      innerJoin: jest.fn().mockReturnThis(),
      leftJoin: jest.fn().mockReturnThis(),
      values: jest.fn().mockReturnThis(),
      returning: jest.fn().mockResolvedValue([{ id: 1, name: 'Inception' }]),
    };

    mockStorage = {
      select: jest.fn<MockQuery, []>().mockReturnValue(mockQuery),
      insert: jest.fn<MockQuery, []>().mockReturnValue(mockQuery),
    };

    service = new StorageService(
      mockStorage as unknown as NodePgDatabase<typeof schema>,
    );
  });

  describe('findAllMovies', () => {
    it('should call select().from(movies)', async () => {
      await service.findAllMovies();
      expect(mockStorage.select).toHaveBeenCalled();
      expect(mockQuery.from).toHaveBeenCalledWith(movies);
    });
  });

  describe('findOrCreatePerson', () => {
    it('should return existing person if found', async () => {
      const existing = {
        id: 42,
        firstName: 'John',
        lastName: 'Doe',
        type: 'ACTOR',
      };
      mockQuery.where.mockResolvedValue([existing]);

      const result = await service.findOrCreatePerson('John', 'Doe', 'ACTOR');

      expect(result).toEqual(existing);
      expect(mockQuery.where).toHaveBeenCalled();
      expect(mockStorage.insert).not.toHaveBeenCalled();
    });

    it('should insert person if not found', async () => {
      const inserted = {
        id: 99,
        firstName: 'Jane',
        lastName: 'Doe',
        type: 'ACTOR',
      };
      mockQuery.where.mockResolvedValue([]);
      mockQuery.returning.mockResolvedValue([inserted]);

      const result = await service.findOrCreatePerson('Jane', 'Doe', 'ACTOR');

      expect(result).toEqual(inserted);
      expect(mockStorage.insert).toHaveBeenCalledWith(people);
      expect(mockQuery.values).toHaveBeenCalledWith({
        firstName: 'Jane',
        lastName: 'Doe',
        type: 'ACTOR',
      });
    });
  });

  describe('insertMovie', () => {
    it('should insert movie and return it', async () => {
      const newMovie = {
        name: 'Tenet',
        year: 2020,
        ageLimit: 13,
        rating: 9,
        synopsis: 'Time-bending thriller',
        directorId: 1,
      };
      const inserted = { id: 5, ...newMovie };

      mockQuery.returning.mockResolvedValue([inserted]);

      const result = await service.insertMovie(newMovie);

      expect(result).toEqual(inserted);
      expect(mockStorage.insert).toHaveBeenCalledWith(movies);
      expect(mockQuery.values).toHaveBeenCalledWith(newMovie);
    });
  });
});
