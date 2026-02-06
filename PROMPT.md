# Part 2: Delete Selected Object Button in Window Title

This section describes how to implement a contextual "Delete" button in the desktop window title bar that appears when an object is selected.

---

## 21. Feature Overview

A delete button that:
- **Appears conditionally** — only visible when an object is selected
- **Positioned in title bar** — before the Share button (right side of window chrome)
- **Uses trash icon** — red-colored for destructive action visibility
- **Provides feedback** — haptic/sound feedback on activation
- **Supports onboarding** — can show tooltip/coach mark on first appearance

```
┌─────────────────────────────────────────────────────────────────┐
│            Document.pdf                     🗑️  📤    ─ □ ×  │
│            ↑ Title                          ↑   ↑             │
│                                           Delete Share Menu     │
└─────────────────────────────────────────────────────────────────┘

🗑️ = Appears ONLY when object is selected
📤 = Share button (always visible)
```

---

## 22. Visual Design

### Icon Specification

```dart
// Icon
Icon: CupertinoIcons.trash  // or Icons.delete_outline
Size: 24x24 logical pixels
Color: Colors.red (#F44336) or CupertinoColors.destructiveRed

// Button container
Width: 48 logical pixels (standard toolbar button)
Height: 48 logical pixels
Alignment: Center
```

### Button States

| State | Icon Color | Background |
|-------|------------|------------|
| Default | `#F44336` (red) | Transparent |
| Hovered | `#D32F2F` (darker red) | `rgba(244, 67, 54, 0.08)` |
| Pressed | `#B71C1C` (darkest red) | `rgba(244, 67, 54, 0.12)` |
| Disabled | `#9E9E9E` (gray) | Transparent |

### CSS/Flutter Equivalent

```dart
// Flutter
IconButton(
  icon: Icon(
    CupertinoIcons.trash,
    color: Colors.red,
    size: 24,
  ),
  onPressed: hasSelection ? _deleteSelected : null,
  tooltip: 'Delete',  // Localized
  splashRadius: 20,
)

// For custom hover effect:
MouseRegion(
  cursor: SystemMouseCursors.click,
  onEnter: (_) => setState(() => _isHovered = true),
  onExit: (_) => setState(() => _isHovered = false),
  child: AnimatedContainer(
    duration: Duration(milliseconds: 150),
    decoration: BoxDecoration(
      color: _isHovered
        ? Colors.red.withOpacity(0.08)
        : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(CupertinoIcons.trash, color: Colors.red),
  ),
)
```

### CSS Styles (for web/Electron)

```css
.delete-button {
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  background: transparent;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 150ms ease;
}

.delete-button:hover {
  background-color: rgba(244, 67, 54, 0.08);
}

.delete-button:active {
  background-color: rgba(244, 67, 54, 0.12);
}

.delete-button svg,
.delete-button .icon {
  width: 24px;
  height: 24px;
  color: #F44336;
}

.delete-button:hover svg,
.delete-button:hover .icon {
  color: #D32F2F;
}

.delete-button:disabled {
  cursor: default;
  opacity: 0;  /* Hide completely when no selection */
  pointer-events: none;
}
```

---

## 23. Conditional Visibility

### State Provider for Selection

```dart
// Selection provider
@riverpod
class EditorSelection extends _$EditorSelection {
  @override
  String? build() => null;  // No selection initially

  void select(String objectId) => state = objectId;
  void clear() => state = null;
}

// Usage in title bar
final selectedId = ref.watch(editorSelectionProvider);
final hasSelection = selectedId != null;
```

### Visibility Animation

Option 1: **Instant show/hide** (simpler)
```dart
if (hasSelection)
  DeleteButton(onPressed: _deleteSelected)
```

Option 2: **Animated fade** (smoother UX)
```dart
AnimatedOpacity(
  opacity: hasSelection ? 1.0 : 0.0,
  duration: Duration(milliseconds: 150),
  child: IgnorePointer(
    ignoring: !hasSelection,
    child: DeleteButton(onPressed: _deleteSelected),
  ),
)
```

Option 3: **Slide in/out** (more noticeable)
```dart
AnimatedSlide(
  offset: hasSelection ? Offset.zero : Offset(0, -1),
  duration: Duration(milliseconds: 200),
  curve: Curves.easeOut,
  child: AnimatedOpacity(
    opacity: hasSelection ? 1.0 : 0.0,
    duration: Duration(milliseconds: 150),
    child: DeleteButton(onPressed: _deleteSelected),
  ),
)
```

---

## 24. Delete Action Implementation

### Core Delete Logic

```dart
void _deleteSelectedObject() {
  final selectedId = ref.read(editorSelectionProvider);
  if (selectedId == null) return;

  // 1. Haptic/audio feedback
  HapticFeedback.mediumImpact();  // Or play sound

  // 2. Remove from placed objects list
  ref.read(placedImagesProvider.notifier).removeImage(selectedId);

  // 3. Clear selection
  ref.read(editorSelectionProvider.notifier).clear();

  // 4. Update document dirty state
  final remainingImages = ref.read(placedImagesProvider);
  if (remainingImages.isEmpty) {
    // No images left = document back to original state
    ref.read(documentDirtyProvider.notifier).markClean();
  }
  // If images remain, document stays dirty (no action needed)
}
```

### Provider Method

```dart
class PlacedImages extends _$PlacedImages {
  void removeImage(String id) {
    state = state.where((img) => img.id != id).toList();
  }
}
```

---

## 25. Keyboard Shortcut

### Delete Key Binding

```dart
// In your keyboard shortcut handler
Shortcuts(
  shortcuts: {
    // Delete/Backspace removes selected object
    SingleActivator(LogicalKeyboardKey.delete): DeleteSelectedIntent(),
    SingleActivator(LogicalKeyboardKey.backspace): DeleteSelectedIntent(),

    // macOS: Cmd+Backspace
    SingleActivator(
      LogicalKeyboardKey.backspace,
      meta: true,
    ): DeleteSelectedIntent(),
  },
  child: Actions(
    actions: {
      DeleteSelectedIntent: CallbackAction<DeleteSelectedIntent>(
        onInvoke: (_) {
          _deleteSelectedObject();
          return null;
        },
      ),
    },
    child: Focus(
      autofocus: true,
      child: YourWidget(),
    ),
  ),
)

class DeleteSelectedIntent extends Intent {
  const DeleteSelectedIntent();
}
```

---

## 26. Title Bar Integration (Desktop)

### Flutter Desktop with Custom Title Bar

```dart
// Using bitsdojo_window or window_manager
class CustomTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.white,
      child: Row(
        children: [
          // Window controls (macOS: left, Windows: right)
          if (Platform.isMacOS) WindowButtons(),

          // Back button
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _goBack,
          ),

          // Title
          Expanded(
            child: GestureDetector(
              onPanStart: (_) => windowManager.startDragging(),
              child: Center(child: Text(documentTitle)),
            ),
          ),

          // Action buttons (right side)
          Consumer(builder: (context, ref, _) {
            final hasSelection = ref.watch(editorSelectionProvider) != null;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // DELETE BUTTON - conditionally visible
                if (hasSelection)
                  _TitleBarButton(
                    icon: CupertinoIcons.trash,
                    iconColor: Colors.red,
                    tooltip: 'Delete',
                    onPressed: _deleteSelected,
                  ),

                // Share button - always visible
                _TitleBarButton(
                  icon: Icons.share,
                  tooltip: 'Share',
                  onPressed: _share,
                ),

                // Menu button
                _TitleBarButton(
                  icon: Icons.more_vert,
                  tooltip: 'Menu',
                  onPressed: _showMenu,
                ),
              ],
            );
          }),

          // Window controls (Windows/Linux: right)
          if (!Platform.isMacOS) WindowButtons(),
        ],
      ),
    );
  }
}
```

### Electron (JavaScript)

```javascript
// In renderer process
function updateTitleBar() {
  const deleteBtn = document.getElementById('delete-btn');
  const selectedObject = store.getState().editor.selectedObjectId;

  if (selectedObject) {
    deleteBtn.style.display = 'flex';
    deleteBtn.onclick = () => deleteSelectedObject();
  } else {
    deleteBtn.style.display = 'none';
  }
}

// Subscribe to selection changes
store.subscribe(() => updateTitleBar());
```

---

## 27. Tooltip and Localization

### Tooltip Text

```dart
// ARB file (English)
{
  "deleteTooltip": "Delete",
  "@deleteTooltip": {
    "description": "Tooltip for delete button in title bar"
  }
}

// Usage
IconButton(
  tooltip: AppLocalizations.of(context).deleteTooltip,
  // ...
)
```

### Multiple Languages Example

| Language | Key | Value |
|----------|-----|-------|
| English | deleteTooltip | Delete |
| Russian | deleteTooltip | Удалить |
| German | deleteTooltip | Löschen |
| Spanish | deleteTooltip | Eliminar |
| French | deleteTooltip | Supprimer |
| Japanese | deleteTooltip | 削除 |
| Chinese | deleteTooltip | 删除 |

---

## 28. Onboarding / Coach Mark

### First-Time Hint

Show a tooltip/coach mark when user first selects an object:

```dart
void _maybeShowDeleteHint() {
  final onboarding = ref.read(onboardingProvider.notifier);

  // Only show if earlier steps completed and this step not yet shown
  if (onboarding.isShown(OnboardingStep.resizeObject) &&
      onboarding.shouldShow(OnboardingStep.deleteImage)) {

    // Wait for button to render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final box = _deleteButtonKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null) return;

      final position = box.localToGlobal(Offset.zero);
      final targetRect = position & box.size;

      CoachMarkController.showAtRect(
        context: context,
        targetRect: targetRect,
        message: 'Tap to delete the selected image',
        arrowDirection: ArrowDirection.up,  // Point up to title bar
        onDismiss: () {
          onboarding.markShown(OnboardingStep.deleteImage);
        },
      );
    });
  }
}

// Trigger when selection changes
ref.listen<String?>(editorSelectionProvider, (previous, next) {
  if (previous == null && next != null) {
    // First selection occurred
    _maybeShowDeleteHint();
  }
});
```

### GlobalKey for Positioning

```dart
final _deleteButtonKey = GlobalKey();

// In build:
IconButton(
  key: _deleteButtonKey,
  icon: Icon(CupertinoIcons.trash),
  // ...
)
```

---

## 29. Feedback Mechanisms

### Haptic Feedback

```dart
// Light impact for hover (optional, macOS trackpad)
HapticFeedback.selectionClick();

// Medium impact on delete action
HapticFeedback.mediumImpact();
```

### Sound Feedback (Optional)

```dart
// Using audioplayers or similar
final player = AudioPlayer();
await player.play(AssetSource('sounds/delete.mp3'));
```

### Visual Feedback

```dart
// Brief flash animation on the canvas where object was
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Image deleted'),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: _undoDelete,
    ),
  ),
);
```

---

## 30. Undo Support (Optional Enhancement)

### Undo Last Delete

```dart
// Store deleted object temporarily
PlacedImage? _lastDeletedImage;
int? _lastDeletedIndex;

void _deleteSelectedObject() {
  final selectedId = ref.read(editorSelectionProvider);
  final images = ref.read(placedImagesProvider);

  final index = images.indexWhere((img) => img.id == selectedId);
  if (index == -1) return;

  // Store for undo
  _lastDeletedImage = images[index];
  _lastDeletedIndex = index;

  // Remove
  ref.read(placedImagesProvider.notifier).removeImage(selectedId!);
  ref.read(editorSelectionProvider.notifier).clear();

  // Show undo snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Image deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: _undoDelete,
      ),
    ),
  );
}

void _undoDelete() {
  if (_lastDeletedImage == null) return;

  ref.read(placedImagesProvider.notifier).insertAt(
    _lastDeletedIndex ?? 0,
    _lastDeletedImage!,
  );

  // Clear undo state
  _lastDeletedImage = null;
  _lastDeletedIndex = null;
}
```

---

## 31. Implementation Checklist

- [ ] **Provider**: Watch selection state in title bar
- [ ] **Icon**: Use trash icon with red color (#F44336)
- [ ] **Position**: Place before Share button in title bar actions
- [ ] **Visibility**: Show only when `selectedId != null`
- [ ] **Animation**: Add fade/slide animation for smooth appearance
- [ ] **Action**: Remove object, clear selection, update dirty state
- [ ] **Keyboard**: Bind Delete/Backspace keys
- [ ] **Tooltip**: Add localized tooltip text
- [ ] **Hover state**: Darker red + subtle background
- [ ] **Haptic**: Medium impact on delete
- [ ] **Onboarding**: Coach mark on first selection (optional)
- [ ] **Undo**: Snackbar with undo action (optional)

---

## 32. Edge Cases

1. **Rapid double-click** — Guard against deleting twice
   ```dart
   if (selectedId == null) return;  // Already cleared
   ```

2. **Delete during drag** — Cancel any active drag before delete
   ```dart
   ref.read(dragStateProvider.notifier).cancelDrag();
   ```

3. **Last object deleted** — Mark document clean
   ```dart
   if (remainingImages.isEmpty) markClean();
   ```

4. **Delete while saving** — Disable button during save operation
   ```dart
   final isSaving = ref.watch(isSavingProvider);
   IconButton(
     onPressed: (hasSelection && !isSaving) ? _delete : null,
   )
   ```

5. **Multi-select delete** — If supporting multiple selection
   ```dart
   void _deleteAllSelected() {
     final selectedIds = ref.read(editorMultiSelectionProvider);
     for (final id in selectedIds) {
       ref.read(placedImagesProvider.notifier).removeImage(id);
     }
     ref.read(editorMultiSelectionProvider.notifier).clearAll();
   }
   ```

---

*This document is intended for use with Claude Code or similar AI coding assistants to implement an equivalent feature in any desktop framework (Flutter, Electron, Qt, etc.).*
