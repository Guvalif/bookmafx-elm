interface BookmarkNode {
  id: string;
  parentId: string | null;
  title: string;
  children: chrome.bookmarks.BookmarkTreeNode[] | null;
}

const Ext = {
  async getBookmarkBar(): Promise<BookmarkNode> {
    return chrome.bookmarks.getTree().then(node => ({
      id: node[0]!.children![0]!.id,
      parentId: null,
      title: 'Bookmark Bar',
      children: node[0]!.children![0]!.children!,
    }));
  },

  async getOtherBookmarks(): Promise<BookmarkNode> {
    return chrome.bookmarks.getTree().then(node => ({
      id: node[0]!.children![1]!.id,
      parentId: null,
      title: 'Other Bookmarks',
      children: node[0]!.children![1]!.children!,
    }));
  },

  async getParentBookmarks(id: string): Promise<BookmarkNode> {
    if (id === '1') return this.getBookmarkBar();
    if (id === '2') return this.getOtherBookmarks();

    const [ node ] = await chrome.bookmarks.get(id);
    const [ parent ] = await chrome.bookmarks.get(node!.parentId!);
    const [ subTree ] = await chrome.bookmarks.getSubTree(node!.parentId!);

    return {
      id: parent!.id,
      parentId: parent!.parentId ?? null,
      title: parent!.title,
      children: subTree!.children ?? null,
    };
  },

  async createFolder(id: string, position?: number): Promise<BookmarkNode> {
    const children = await chrome.bookmarks.getChildren(id);
    const index = children.length ? position! + 1 : 0;

    return chrome.bookmarks.create({
      index,
      parentId: id,
      title: '新しいフォルダ',
    }).then(node => ({
      id: node.id,
      parentId: id,
      title: '新しいフォルダ',
      children: [],
    }));
  },

  async updateBookmarkTitle(id: string, title: string): Promise<void> {
    return chrome.bookmarks.update(id, { title }) as any;
  },

  async removeBookmark(id: string): Promise<void> {
    return chrome.bookmarks.removeTree(id);
  },
};
