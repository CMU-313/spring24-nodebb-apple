const Posts = require('./posts');

jest.mock('nodebb-plugin-require-main', () => ({
  require: {
    './src/database': {
      setObject: jest.fn(() => Promise.resolve()),
      incrObjectField: jest.fn(() => Promise.resolve(1)),
    },
    './src/topics': {
      getTopicFields: jest.fn(() => Promise.resolve({ cid: 1, pinned: false })),
    },
    './src/plugins': {
      hooks: {
        fire: jest.fn((hook, data) => Promise.resolve(data)),
      },
    },
    './src/user': {
      getUserData: jest.fn(() => Promise.resolve({ username: 'testuser' })),
    },
    './src/utils': {
      isNumber: jest.fn(() => true),
    },
  },
}));

describe('Posts.create', () => {
  it('creates a named post successfully', async () => {
    const postData = {
      uid: 1,
      tid: 1,
      content: 'This is a test post',
      isAnonymous: false,
    };

    const post = await Posts.create(postData);

    expect(post).toBeDefined();
    expect(post.uid).toEqual(1);
    expect(post.content).toEqual('This is a test post');
  });

  it('creates an anonymous post successfully', async () => {
    const postData = {
      uid: 1,
      tid: 1,
      content: 'This is an anonymous test post',
      isAnonymous: true,
    };

    const post = await Posts.create(postData);

    expect(post).toBeDefined();
    expect(post.uid).toEqual(-1);
    expect(post.content).toEqual('This is an anonymous test post');
  });
});

// Writen by ChatGPT
