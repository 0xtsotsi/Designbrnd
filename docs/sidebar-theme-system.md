# Toggleable Sidebar & Theme System

## AutoMaker-Inspired Navigation for Design OS

---

## Overview

This document outlines the implementation of a collapsible sidebar navigation system with multiple color themes and background customization, inspired by AutoMaker's design.

---

## Features

### 1. **Toggleable Sidebar**
- Collapsible left navigation (240px expanded, 64px collapsed)
- Smooth animations (200ms ease transitions)
- Persistent state across sessions
- Keyboard shortcut: `Cmd/Ctrl + B`

### 2. **Color Themes**
Multiple pre-defined themes with instant switching:
- **Midnight** - Deep blacks (#000000, #09090b) - Default Vibe theme
- **Slate** - Cool grays (#0f172a, #1e293b)
- **Obsidian** - Warm blacks (#0a0a0a, #171717)
- **Ocean** - Blue-tinted darks (#001a2e, #002a4a)
- **Forest** - Green-tinted darks (#001a0a, #002a14)
- **Custom** - User-defined colors

### 3. **Background Customization**
- Solid colors
- Gradient overlays
- Pattern options (grid, dots, noise)
- Image upload with opacity control
- Blur/brightness adjustments

### 4. **Design OS Navigation**
Organized into sections:
- **Workflow** (Overview, Board, Planning)
- **Tools** (Mockups, Review, Export)
- **Project** (Settings, Team, Integrations)

### 5. **Metrics Dashboard**
Live stats in sidebar:
- Cards completed this week
- Active tasks by lane
- Client approval rate
- Time saved with automation

---

## Component Architecture

```
src/
├── components/
│   ├── layout/
│   │   ├── Sidebar.tsx                 # Main sidebar container
│   │   ├── SidebarNav.tsx              # Navigation links
│   │   ├── SidebarMetrics.tsx          # Metrics display
│   │   ├── SidebarFooter.tsx           # Settings, theme, profile
│   │   └── SidebarToggle.tsx           # Collapse button
│   │
│   └── theme/
│       ├── ThemeSelector.tsx           # Theme picker modal
│       ├── BackgroundCustomizer.tsx    # Background options
│       ├── ThemePreview.tsx            # Theme preview cards
│       └── ColorPicker.tsx             # Custom color picker
│
├── lib/
│   ├── state/
│   │   ├── sidebar-store.ts            # Sidebar state
│   │   └── theme-store.ts              # Theme/background state
│   │
│   └── themes/
│       ├── themes.ts                   # Theme definitions
│       └── backgrounds.ts              # Background patterns
│
└── styles/
    └── theme-variables.css             # CSS custom properties
```

---

## Theme System

### Theme Structure

```typescript
// src/lib/themes/themes.ts

export interface Theme {
  id: string;
  name: string;
  colors: {
    // Backgrounds
    bg: {
      primary: string;      // Main background
      secondary: string;    // Cards, panels
      tertiary: string;     // Hover states
    };
    // Borders
    border: {
      default: string;
      hover: string;
      active: string;
    };
    // Text
    text: {
      primary: string;
      secondary: string;
      muted: string;
    };
    // Accents
    accent: {
      primary: string;      // Brand color
      success: string;      // Green
      warning: string;      // Yellow
      danger: string;       // Red
      info: string;         // Blue
    };
    // Sidebar specific
    sidebar: {
      bg: string;
      border: string;
      itemHover: string;
      itemActive: string;
    };
  };
}

export const themes: Theme[] = [
  {
    id: 'midnight',
    name: 'Midnight',
    colors: {
      bg: {
        primary: '#000000',
        secondary: '#09090b',
        tertiary: '#18181b',
      },
      border: {
        default: '#27272a',
        hover: '#3f3f46',
        active: '#52525b',
      },
      text: {
        primary: '#fafafa',
        secondary: '#a1a1aa',
        muted: '#71717a',
      },
      accent: {
        primary: '#3b82f6',
        success: '#22c55e',
        warning: '#eab308',
        danger: '#ef4444',
        info: '#06b6d4',
      },
      sidebar: {
        bg: '#000000',
        border: '#27272a',
        itemHover: '#18181b',
        itemActive: '#1e1e1e',
      },
    },
  },
  {
    id: 'slate',
    name: 'Slate',
    colors: {
      bg: {
        primary: '#0f172a',
        secondary: '#1e293b',
        tertiary: '#334155',
      },
      border: {
        default: '#334155',
        hover: '#475569',
        active: '#64748b',
      },
      text: {
        primary: '#f1f5f9',
        secondary: '#cbd5e1',
        muted: '#94a3b8',
      },
      accent: {
        primary: '#0ea5e9',
        success: '#10b981',
        warning: '#f59e0b',
        danger: '#f43f5e',
        info: '#06b6d4',
      },
      sidebar: {
        bg: '#0f172a',
        border: '#334155',
        itemHover: '#1e293b',
        itemActive: '#334155',
      },
    },
  },
  {
    id: 'obsidian',
    name: 'Obsidian',
    colors: {
      bg: {
        primary: '#0a0a0a',
        secondary: '#171717',
        tertiary: '#262626',
      },
      border: {
        default: '#404040',
        hover: '#525252',
        active: '#737373',
      },
      text: {
        primary: '#fafafa',
        secondary: '#d4d4d4',
        muted: '#a3a3a3',
      },
      accent: {
        primary: '#8b5cf6',
        success: '#22c55e',
        warning: '#f59e0b',
        danger: '#ef4444',
        info: '#3b82f6',
      },
      sidebar: {
        bg: '#0a0a0a',
        border: '#404040',
        itemHover: '#171717',
        itemActive: '#262626',
      },
    },
  },
  {
    id: 'ocean',
    name: 'Ocean',
    colors: {
      bg: {
        primary: '#001a2e',
        secondary: '#002a4a',
        tertiary: '#003d66',
      },
      border: {
        default: '#004d7a',
        hover: '#005d8f',
        active: '#0077b6',
      },
      text: {
        primary: '#e0f2fe',
        secondary: '#bae6fd',
        muted: '#7dd3fc',
      },
      accent: {
        primary: '#0ea5e9',
        success: '#14b8a6',
        warning: '#fbbf24',
        danger: '#f43f5e',
        info: '#06b6d4',
      },
      sidebar: {
        bg: '#001a2e',
        border: '#004d7a',
        itemHover: '#002a4a',
        itemActive: '#003d66',
      },
    },
  },
  {
    id: 'forest',
    name: 'Forest',
    colors: {
      bg: {
        primary: '#001a0a',
        secondary: '#002a14',
        tertiary: '#003d1f',
      },
      border: {
        default: '#004d28',
        hover: '#005d32',
        active: '#007740',
      },
      text: {
        primary: '#d1fae5',
        secondary: '#a7f3d0',
        muted: '#6ee7b7',
      },
      accent: {
        primary: '#10b981',
        success: '#22c55e',
        warning: '#fbbf24',
        danger: '#f43f5e',
        info: '#06b6d4',
      },
      sidebar: {
        bg: '#001a0a',
        border: '#004d28',
        itemHover: '#002a14',
        itemActive: '#003d1f',
      },
    },
  },
];
```

---

## Background System

```typescript
// src/lib/themes/backgrounds.ts

export type BackgroundType = 'solid' | 'gradient' | 'pattern' | 'image';

export interface Background {
  type: BackgroundType;
  value: string;
  opacity?: number;
  blur?: number;
  brightness?: number;
}

export const backgroundPatterns = [
  {
    id: 'grid',
    name: 'Grid',
    css: `
      background-image:
        linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
      background-size: 20px 20px;
    `,
  },
  {
    id: 'dots',
    name: 'Dots',
    css: `
      background-image: radial-gradient(circle, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
      background-size: 20px 20px;
    `,
  },
  {
    id: 'noise',
    name: 'Noise',
    css: `
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.05'/%3E%3C/svg%3E");
    `,
  },
  {
    id: 'diagonal',
    name: 'Diagonal Lines',
    css: `
      background-image: repeating-linear-gradient(
        45deg,
        transparent,
        transparent 10px,
        rgba(255, 255, 255, 0.02) 10px,
        rgba(255, 255, 255, 0.02) 20px
      );
    `,
  },
];

export const gradientPresets = [
  {
    id: 'aurora',
    name: 'Aurora',
    value: 'linear-gradient(135deg, rgba(59, 130, 246, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%)',
  },
  {
    id: 'sunset',
    name: 'Sunset',
    value: 'linear-gradient(135deg, rgba(239, 68, 68, 0.1) 0%, rgba(249, 115, 22, 0.1) 100%)',
  },
  {
    id: 'ocean',
    name: 'Ocean',
    value: 'linear-gradient(135deg, rgba(6, 182, 212, 0.1) 0%, rgba(59, 130, 246, 0.1) 100%)',
  },
  {
    id: 'forest',
    name: 'Forest',
    value: 'linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(34, 197, 94, 0.1) 100%)',
  },
];
```

---

## State Management

```typescript
// src/lib/state/sidebar-store.ts

import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface SidebarStore {
  isCollapsed: boolean;
  toggle: () => void;
  collapse: () => void;
  expand: () => void;
}

export const useSidebarStore = create<SidebarStore>()(
  persist(
    (set) => ({
      isCollapsed: false,

      toggle: () => set((state) => ({ isCollapsed: !state.isCollapsed })),
      collapse: () => set({ isCollapsed: true }),
      expand: () => set({ isCollapsed: false }),
    }),
    {
      name: 'sidebar-state',
    }
  )
);
```

```typescript
// src/lib/state/theme-store.ts

import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { themes } from '../themes/themes';
import type { Theme, Background } from '../themes/themes';

interface ThemeStore {
  currentTheme: Theme;
  customTheme?: Theme;
  background: Background | null;

  setTheme: (themeId: string) => void;
  setCustomTheme: (theme: Theme) => void;
  setBackground: (background: Background) => void;
  clearBackground: () => void;
}

export const useThemeStore = create<ThemeStore>()(
  persist(
    (set) => ({
      currentTheme: themes[0], // Midnight by default
      customTheme: undefined,
      background: null,

      setTheme: (themeId) => {
        const theme = themes.find((t) => t.id === themeId);
        if (theme) {
          set({ currentTheme: theme });
          applyTheme(theme);
        }
      },

      setCustomTheme: (theme) => {
        set({ currentTheme: theme, customTheme: theme });
        applyTheme(theme);
      },

      setBackground: (background) => {
        set({ background });
        applyBackground(background);
      },

      clearBackground: () => {
        set({ background: null });
        document.documentElement.style.removeProperty('--bg-pattern');
      },
    }),
    {
      name: 'theme-state',
    }
  )
);

function applyTheme(theme: Theme) {
  const root = document.documentElement;

  // Apply all color variables
  Object.entries(theme.colors).forEach(([category, values]) => {
    Object.entries(values).forEach(([key, value]) => {
      root.style.setProperty(`--color-${category}-${key}`, value);
    });
  });
}

function applyBackground(background: Background) {
  const root = document.documentElement;

  switch (background.type) {
    case 'solid':
      root.style.setProperty('--bg-pattern', background.value);
      break;
    case 'gradient':
      root.style.setProperty('--bg-pattern', background.value);
      break;
    case 'pattern':
      root.style.setProperty('--bg-pattern', background.value);
      break;
    case 'image':
      root.style.setProperty(
        '--bg-pattern',
        `url(${background.value})`
      );
      if (background.opacity) {
        root.style.setProperty('--bg-opacity', background.opacity.toString());
      }
      break;
  }
}
```

---

## Components

### 1. Main Sidebar Component

```typescript
// src/components/layout/Sidebar.tsx

import { useSidebarStore } from '@/lib/state/sidebar-store';
import { useThemeStore } from '@/lib/state/theme-store';
import { SidebarNav } from './SidebarNav';
import { SidebarMetrics } from './SidebarMetrics';
import { SidebarFooter } from './SidebarFooter';
import { SidebarToggle } from './SidebarToggle';
import { cn } from '@/lib/utils';

export function Sidebar() {
  const { isCollapsed } = useSidebarStore();
  const { currentTheme } = useThemeStore();

  return (
    <aside
      className={cn(
        'fixed left-0 top-0 h-screen border-r transition-all duration-200 ease-in-out',
        isCollapsed ? 'w-16' : 'w-60',
        'flex flex-col'
      )}
      style={{
        backgroundColor: currentTheme.colors.sidebar.bg,
        borderColor: currentTheme.colors.sidebar.border,
      }}
    >
      {/* Header */}
      <div className="h-14 flex items-center justify-between px-4 border-b"
        style={{ borderColor: currentTheme.colors.sidebar.border }}
      >
        {!isCollapsed && (
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
              <span className="text-white font-bold text-sm">DS</span>
            </div>
            <span className="font-semibold" style={{ color: currentTheme.colors.text.primary }}>
              Design OS
            </span>
          </div>
        )}
        <SidebarToggle />
      </div>

      {/* Navigation */}
      <div className="flex-1 overflow-y-auto py-4">
        <SidebarNav collapsed={isCollapsed} />
      </div>

      {/* Metrics */}
      {!isCollapsed && (
        <div className="border-t px-4 py-3" style={{ borderColor: currentTheme.colors.sidebar.border }}>
          <SidebarMetrics />
        </div>
      )}

      {/* Footer */}
      <SidebarFooter collapsed={isCollapsed} />
    </aside>
  );
}
```

### 2. Navigation Links

```typescript
// src/components/layout/SidebarNav.tsx

import { Link, useLocation } from 'react-router-dom';
import { useThemeStore } from '@/lib/state/theme-store';
import { cn } from '@/lib/utils';
import {
  LayoutDashboard,
  Kanban,
  Pencil,
  Palette,
  FileCheck,
  Package,
  Settings,
  Users,
  Plug,
} from 'lucide-react';

interface NavItem {
  id: string;
  label: string;
  icon: React.ComponentType<{ className?: string }>;
  path: string;
  section?: string;
}

const navItems: NavItem[] = [
  { id: 'overview', label: 'Overview', icon: LayoutDashboard, path: '/', section: 'Workflow' },
  { id: 'board', label: 'Board', icon: Kanban, path: '/board', section: 'Workflow' },
  { id: 'planning', label: 'Planning', icon: Pencil, path: '/planning', section: 'Workflow' },

  { id: 'mockups', label: 'Mockups', icon: Palette, path: '/mockups', section: 'Tools' },
  { id: 'review', label: 'Review', icon: FileCheck, path: '/review', section: 'Tools' },
  { id: 'export', label: 'Export', icon: Package, path: '/export', section: 'Tools' },

  { id: 'settings', label: 'Settings', icon: Settings, path: '/settings', section: 'Project' },
  { id: 'team', label: 'Team', icon: Users, path: '/team', section: 'Project' },
  { id: 'integrations', label: 'Integrations', icon: Plug, path: '/integrations', section: 'Project' },
];

interface SidebarNavProps {
  collapsed: boolean;
}

export function SidebarNav({ collapsed }: SidebarNavProps) {
  const location = useLocation();
  const { currentTheme } = useThemeStore();

  // Group items by section
  const sections = navItems.reduce((acc, item) => {
    const section = item.section || 'General';
    if (!acc[section]) acc[section] = [];
    acc[section].push(item);
    return acc;
  }, {} as Record<string, NavItem[]>);

  return (
    <nav className="space-y-6">
      {Object.entries(sections).map(([section, items]) => (
        <div key={section}>
          {!collapsed && (
            <div
              className="px-4 mb-2 text-xs font-semibold uppercase tracking-wider"
              style={{ color: currentTheme.colors.text.muted }}
            >
              {section}
            </div>
          )}
          <div className="space-y-1 px-2">
            {items.map((item) => {
              const isActive = location.pathname === item.path;
              const Icon = item.icon;

              return (
                <Link
                  key={item.id}
                  to={item.path}
                  className={cn(
                    'flex items-center gap-3 px-3 py-2 rounded-lg transition-colors',
                    collapsed ? 'justify-center' : '',
                    isActive
                      ? 'font-medium'
                      : 'hover:bg-opacity-50'
                  )}
                  style={{
                    backgroundColor: isActive
                      ? currentTheme.colors.sidebar.itemActive
                      : 'transparent',
                    color: isActive
                      ? currentTheme.colors.text.primary
                      : currentTheme.colors.text.secondary,
                  }}
                  title={collapsed ? item.label : undefined}
                >
                  <Icon className="w-5 h-5 flex-shrink-0" />
                  {!collapsed && <span>{item.label}</span>}
                </Link>
              );
            })}
          </div>
        </div>
      ))}
    </nav>
  );
}
```

### 3. Metrics Display

```typescript
// src/components/layout/SidebarMetrics.tsx

import { useThemeStore } from '@/lib/state/theme-store';
import { useBoardStore } from '@/lib/state/board-store';
import { CheckCircle2, Clock, TrendingUp } from 'lucide-react';

export function SidebarMetrics() {
  const { currentTheme } = useThemeStore();
  const { board } = useBoardStore();

  // Calculate metrics
  const totalCards = board?.lanes.flatMap((l) => l.cards).length || 0;
  const doneCards = board?.lanes.find((l) => l.id === 'done')?.cards.length || 0;
  const inProgressCards = board?.lanes
    .filter((l) => l.id !== 'done')
    .flatMap((l) => l.cards).length || 0;

  const completionRate = totalCards > 0 ? Math.round((doneCards / totalCards) * 100) : 0;

  const metrics = [
    {
      icon: CheckCircle2,
      label: 'Completed',
      value: doneCards,
      color: currentTheme.colors.accent.success,
    },
    {
      icon: Clock,
      label: 'In Progress',
      value: inProgressCards,
      color: currentTheme.colors.accent.warning,
    },
    {
      icon: TrendingUp,
      label: 'Completion',
      value: `${completionRate}%`,
      color: currentTheme.colors.accent.primary,
    },
  ];

  return (
    <div className="space-y-2">
      <div
        className="text-xs font-semibold uppercase tracking-wider mb-3"
        style={{ color: currentTheme.colors.text.muted }}
      >
        This Week
      </div>
      {metrics.map((metric) => {
        const Icon = metric.icon;
        return (
          <div key={metric.label} className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Icon className="w-4 h-4" style={{ color: metric.color }} />
              <span className="text-sm" style={{ color: currentTheme.colors.text.secondary }}>
                {metric.label}
              </span>
            </div>
            <span className="text-sm font-semibold" style={{ color: currentTheme.colors.text.primary }}>
              {metric.value}
            </span>
          </div>
        );
      })}
    </div>
  );
}
```

### 4. Footer with Theme Selector

```typescript
// src/components/layout/SidebarFooter.tsx

import { useState } from 'react';
import { useThemeStore } from '@/lib/state/theme-store';
import { Palette, User, Settings } from 'lucide-react';
import { ThemeSelector } from '../theme/ThemeSelector';
import { cn } from '@/lib/utils';

interface SidebarFooterProps {
  collapsed: boolean;
}

export function SidebarFooter({ collapsed }: SidebarFooterProps) {
  const { currentTheme } = useThemeStore();
  const [showThemeSelector, setShowThemeSelector] = useState(false);

  return (
    <>
      <div
        className="border-t p-2"
        style={{ borderColor: currentTheme.colors.sidebar.border }}
      >
        <div className={cn('flex gap-1', collapsed ? 'flex-col' : 'flex-row')}>
          <button
            onClick={() => setShowThemeSelector(true)}
            className="flex-1 p-2 rounded-lg hover:bg-opacity-50 transition-colors"
            style={{
              color: currentTheme.colors.text.secondary,
            }}
            title={collapsed ? 'Themes' : undefined}
          >
            <Palette className={cn('w-5 h-5', collapsed ? 'mx-auto' : '')} />
            {!collapsed && <span className="ml-2 text-sm">Themes</span>}
          </button>

          {!collapsed && (
            <>
              <button
                className="p-2 rounded-lg hover:bg-opacity-50 transition-colors"
                style={{
                  color: currentTheme.colors.text.secondary,
                }}
              >
                <Settings className="w-5 h-5" />
              </button>

              <button
                className="p-2 rounded-lg hover:bg-opacity-50 transition-colors"
                style={{
                  color: currentTheme.colors.text.secondary,
                }}
              >
                <User className="w-5 h-5" />
              </button>
            </>
          )}
        </div>
      </div>

      <ThemeSelector
        open={showThemeSelector}
        onClose={() => setShowThemeSelector(false)}
      />
    </>
  );
}
```

### 5. Toggle Button

```typescript
// src/components/layout/SidebarToggle.tsx

import { useSidebarStore } from '@/lib/state/sidebar-store';
import { useThemeStore } from '@/lib/state/theme-store';
import { PanelLeftClose, PanelLeft } from 'lucide-react';

export function SidebarToggle() {
  const { isCollapsed, toggle } = useSidebarStore();
  const { currentTheme } = useThemeStore();

  return (
    <button
      onClick={toggle}
      className="p-1.5 rounded-lg hover:bg-opacity-50 transition-colors"
      style={{
        color: currentTheme.colors.text.secondary,
      }}
      title={isCollapsed ? 'Expand sidebar' : 'Collapse sidebar'}
    >
      {isCollapsed ? (
        <PanelLeft className="w-5 h-5" />
      ) : (
        <PanelLeftClose className="w-5 h-5" />
      )}
    </button>
  );
}
```

---

## Theme Selector Modal

```typescript
// src/components/theme/ThemeSelector.tsx

import { useState } from 'react';
import { useThemeStore } from '@/lib/state/theme-store';
import { themes } from '@/lib/themes/themes';
import { BackgroundCustomizer } from './BackgroundCustomizer';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTabs,
  DialogTabsList,
  DialogTabsTrigger,
  DialogTabsContent,
} from '@/components/ui/dialog';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Check } from 'lucide-react';

interface ThemeSelectorProps {
  open: boolean;
  onClose: () => void;
}

export function ThemeSelector({ open, onClose }: ThemeSelectorProps) {
  const { currentTheme, setTheme } = useThemeStore();

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl">
        <DialogHeader>
          <DialogTitle>Customize Appearance</DialogTitle>
        </DialogHeader>

        <Tabs defaultValue="themes">
          <TabsList>
            <TabsTrigger value="themes">Color Themes</TabsTrigger>
            <TabsTrigger value="background">Background</TabsTrigger>
          </TabsList>

          <TabsContent value="themes" className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              {themes.map((theme) => {
                const isActive = currentTheme.id === theme.id;

                return (
                  <button
                    key={theme.id}
                    onClick={() => setTheme(theme.id)}
                    className="relative p-4 rounded-lg border-2 transition-all hover:scale-105"
                    style={{
                      backgroundColor: theme.colors.bg.primary,
                      borderColor: isActive
                        ? theme.colors.accent.primary
                        : theme.colors.border.default,
                    }}
                  >
                    {isActive && (
                      <div
                        className="absolute top-2 right-2 w-6 h-6 rounded-full flex items-center justify-center"
                        style={{ backgroundColor: theme.colors.accent.primary }}
                      >
                        <Check className="w-4 h-4 text-white" />
                      </div>
                    )}

                    <div className="text-left">
                      <div
                        className="font-semibold mb-2"
                        style={{ color: theme.colors.text.primary }}
                      >
                        {theme.name}
                      </div>

                      <div className="flex gap-2">
                        <div
                          className="w-8 h-8 rounded"
                          style={{ backgroundColor: theme.colors.bg.secondary }}
                        />
                        <div
                          className="w-8 h-8 rounded"
                          style={{ backgroundColor: theme.colors.accent.primary }}
                        />
                        <div
                          className="w-8 h-8 rounded"
                          style={{ backgroundColor: theme.colors.accent.success }}
                        />
                      </div>
                    </div>
                  </button>
                );
              })}
            </div>
          </TabsContent>

          <TabsContent value="background">
            <BackgroundCustomizer />
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
}
```

---

## Background Customizer

```typescript
// src/components/theme/BackgroundCustomizer.tsx

import { useState } from 'react';
import { useThemeStore } from '@/lib/state/theme-store';
import { backgroundPatterns, gradientPresets } from '@/lib/themes/backgrounds';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Slider } from '@/components/ui/slider';

export function BackgroundCustomizer() {
  const { background, setBackground, clearBackground } = useThemeStore();
  const [opacity, setOpacity] = useState(background?.opacity || 100);

  return (
    <div className="space-y-6">
      <Tabs defaultValue="pattern">
        <TabsList>
          <TabsTrigger value="pattern">Patterns</TabsTrigger>
          <TabsTrigger value="gradient">Gradients</TabsTrigger>
          <TabsTrigger value="image">Custom Image</TabsTrigger>
        </TabsList>

        <TabsContent value="pattern" className="space-y-4">
          <div className="grid grid-cols-2 gap-3">
            {backgroundPatterns.map((pattern) => (
              <button
                key={pattern.id}
                onClick={() =>
                  setBackground({
                    type: 'pattern',
                    value: pattern.css,
                  })
                }
                className="p-4 rounded-lg border hover:border-blue-500 transition-colors"
                style={{
                  backgroundImage: pattern.css,
                }}
              >
                <div className="text-sm font-medium">{pattern.name}</div>
              </button>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="gradient" className="space-y-4">
          <div className="grid grid-cols-2 gap-3">
            {gradientPresets.map((gradient) => (
              <button
                key={gradient.id}
                onClick={() =>
                  setBackground({
                    type: 'gradient',
                    value: gradient.value,
                  })
                }
                className="p-4 rounded-lg border hover:border-blue-500 transition-colors"
                style={{
                  background: gradient.value,
                }}
              >
                <div className="text-sm font-medium">{gradient.name}</div>
              </button>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="image" className="space-y-4">
          <div>
            <Label>Image URL</Label>
            <Input
              placeholder="https://example.com/image.jpg"
              onChange={(e) => {
                if (e.target.value) {
                  setBackground({
                    type: 'image',
                    value: e.target.value,
                    opacity,
                  });
                }
              }}
            />
          </div>

          <div>
            <Label>Opacity: {opacity}%</Label>
            <Slider
              value={[opacity]}
              onValueChange={([value]) => setOpacity(value)}
              min={0}
              max={100}
              step={5}
            />
          </div>
        </TabsContent>
      </Tabs>

      <div className="flex justify-between">
        <Button variant="outline" onClick={clearBackground}>
          Clear Background
        </Button>
        <Button onClick={() => {}}>Apply</Button>
      </div>
    </div>
  );
}
```

---

## CSS Variables

```css
/* src/styles/theme-variables.css */

:root {
  /* Backgrounds */
  --color-bg-primary: #000000;
  --color-bg-secondary: #09090b;
  --color-bg-tertiary: #18181b;

  /* Borders */
  --color-border-default: #27272a;
  --color-border-hover: #3f3f46;
  --color-border-active: #52525b;

  /* Text */
  --color-text-primary: #fafafa;
  --color-text-secondary: #a1a1aa;
  --color-text-muted: #71717a;

  /* Accents */
  --color-accent-primary: #3b82f6;
  --color-accent-success: #22c55e;
  --color-accent-warning: #eab308;
  --color-accent-danger: #ef4444;
  --color-accent-info: #06b6d4;

  /* Sidebar */
  --color-sidebar-bg: #000000;
  --color-sidebar-border: #27272a;
  --color-sidebar-item-hover: #18181b;
  --color-sidebar-item-active: #1e1e1e;

  /* Background pattern */
  --bg-pattern: none;
  --bg-opacity: 1;
}

body {
  background-color: var(--color-bg-primary);
  color: var(--color-text-primary);
}

body::before {
  content: '';
  position: fixed;
  inset: 0;
  background: var(--bg-pattern);
  opacity: var(--bg-opacity);
  pointer-events: none;
  z-index: -1;
}
```

---

## Keyboard Shortcuts

```typescript
// src/hooks/useKeyboardShortcuts.ts

import { useEffect } from 'react';
import { useSidebarStore } from '@/lib/state/sidebar-store';

export function useKeyboardShortcuts() {
  const { toggle } = useSidebarStore();

  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      // Cmd/Ctrl + B: Toggle sidebar
      if ((e.metaKey || e.ctrlKey) && e.key === 'b') {
        e.preventDefault();
        toggle();
      }

      // Cmd/Ctrl + ,: Open settings
      if ((e.metaKey || e.ctrlKey) && e.key === ',') {
        e.preventDefault();
        // Navigate to settings
      }
    };

    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [toggle]);
}

// Use in App.tsx
function App() {
  useKeyboardShortcuts();
  // ...
}
```

---

## Implementation Checklist

### Phase 1: Basic Sidebar (Day 1-2)
- [ ] Create sidebar component structure
- [ ] Implement collapse/expand functionality
- [ ] Add navigation links
- [ ] Style with default theme
- [ ] Add keyboard shortcut (Cmd+B)

### Phase 2: Theme System (Day 3-4)
- [ ] Create theme definitions (5 themes)
- [ ] Build theme store with Zustand
- [ ] Implement theme selector modal
- [ ] Apply themes with CSS variables
- [ ] Add theme preview cards

### Phase 3: Background Customization (Day 5)
- [ ] Create background patterns
- [ ] Add gradient presets
- [ ] Build background customizer UI
- [ ] Implement image upload
- [ ] Add opacity/blur controls

### Phase 4: Metrics & Polish (Day 6-7)
- [ ] Add metrics display
- [ ] Calculate stats from board store
- [ ] Add smooth transitions
- [ ] Test all themes
- [ ] Mobile responsiveness

---

## Usage Example

```typescript
// src/App.tsx

import { Sidebar } from '@/components/layout/Sidebar';
import { useSidebarStore } from '@/lib/state/sidebar-store';
import { useThemeStore } from '@/lib/state/theme-store';
import { useKeyboardShortcuts } from '@/hooks/useKeyboardShortcuts';

function App() {
  const { isCollapsed } = useSidebarStore();
  const { currentTheme } = useThemeStore();

  useKeyboardShortcuts();

  return (
    <div className="flex h-screen">
      <Sidebar />

      <main
        className={cn(
          'flex-1 transition-all duration-200',
          isCollapsed ? 'ml-16' : 'ml-60'
        )}
        style={{
          backgroundColor: currentTheme.colors.bg.primary,
        }}
      >
        {/* Your dashboard content */}
      </main>
    </div>
  );
}
```

---

## Next Steps

1. Review this design
2. Choose preferred themes (keep all 5 or customize?)
3. Decide on metrics to display
4. Any additional customization options?

Ready to implement! 🚀
