# Files & Attachments

## Downloading Files

```python
# Get raw Markdown content of an attachment
raw = zot.file('ATTACHMENTKEY')
with open('paper.md', 'wb') as f:
    f.write(raw)

# Convenient wrapper: dump file to disk
# Uses stored filename, saves to current directory
zot.dump('ATTACHMENTKEY')

# Dump to a specific path and filename
zot.dump('ATTACHMENTKEY', 'renamed_paper.md', '/home/user/papers/')
# Returns the full file path on success
```

**Note**: HTML snapshots are dumped as `.zip` files named with the item key.

## Finding Attachments

```python
# Get child items (attachments, notes) of a parent item
children = zot.children('PARENTKEY')
attachments = [c for c in children if c['data']['itemType'] == 'attachment']

# Get the attachment key
for att in attachments:
    key = att['data']['key']
    filename = att['data']['filename']
    content_type = att['data']['contentType']
    link_mode = att['data']['linkMode']  # 'imported_file', 'linked_file', 'imported_url', 'linked_url'
```

## Uploading Attachments

**Note**: Attachment upload methods are in beta.

```python
# Simple upload: one or more files by path
result = zot.attachment_simple(['/path/to/paper.md', '/path/to/notes.docx'])

# Upload as child items of a parent
result = zot.attachment_simple(['/path/to/paper.md'], parentid='PARENTKEY')

# Upload with custom filenames: list of (name, path) tuples
result = zot.attachment_both([
    ('Paper 2024.md', '/path/to/paper.md'),
    ('Supplementary.md', '/path/to/supp.md'),
], parentid='PARENTKEY')

# Upload files to existing attachment items
result = zot.upload_attachments(attachment_items, basedir='/path/to/files/')
```

Upload result structure:
```python
{
    'success': [attachment_item1, ...],
    'failure': [attachment_item2, ...],
    'unchanged': [attachment_item3, ...]
}
```

## Attachment Templates

```python
# Get template for a file attachment
template = zot.item_template('attachment', linkmode='imported_file')
# linkmode options: 'imported_file', 'linked_file', 'imported_url', 'linked_url'

# Available link modes
modes = zot.item_attachment_link_modes()
```

## Downloading All Markdown Notes from a Collection

```python
import os

collection_key = 'COLKEY'
output_dir = '/path/to/output/'
os.makedirs(output_dir, exist_ok=True)

items = zot.everything(zot.collection_items(collection_key))
for item in items:
    children = zot.children(item['data']['key'])
    for child in children:
        if child['data']['itemType'] == 'attachment' and \
           child['data'].get('contentType') in {'text/markdown', 'text/plain'}:
            try:
                zot.dump(child['data']['key'], path=output_dir)
            except Exception as e:
                print(f"Failed to download {child['data']['key']}: {e}")
```
