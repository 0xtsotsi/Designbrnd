import { useState } from 'react'
import { useNavigate, useLocation } from 'react-router-dom'
import {
  Plus,
  FolderOpen,
  Layout,
  Image,
  ListChecks,
  Layers,
  Terminal as TerminalIcon,
  Settings,
  X,
  ChevronDown,
  MoreVertical,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'

interface SidebarProps {
  className?: string
}

export function Sidebar({ className }: SidebarProps) {
  const navigate = useNavigate()
  const location = useLocation()
  const [currentProject, setCurrentProject] = useState('Designbrnd Project')

  const isActive = (path: string) => location.pathname === path

  const projectItems = [
    {
      name: 'Kanban Board',
      icon: Layout,
      path: '/kanban',
      badge: null
    },
  ]

  const toolItems = [
    {
      name: 'Plannotator',
      icon: FolderOpen,
      path: '/plannotator',
      badge: null
    },
    {
      name: 'ShowMe',
      icon: Image,
      path: '/showme',
      badge: null
    },
    {
      name: 'Beads',
      icon: ListChecks,
      path: '/beads',
      badge: null
    },
    {
      name: 'Design OS',
      icon: Layers,
      path: '/',
      badge: null
    },
    {
      name: 'Terminal',
      icon: TerminalIcon,
      path: '/terminal',
      badge: null
    },
  ]

  return (
    <aside className={cn(
      "w-56 h-screen bg-[#0a0f1a] border-r border-stone-800 flex flex-col text-stone-300",
      className
    )}>
      {/* Header */}
      <div className="px-4 py-4 border-b border-stone-800 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded bg-cyan-500 flex items-center justify-center">
            <Layers className="w-5 h-5 text-white" strokeWidth={2} />
          </div>
          <span className="text-white font-semibold text-lg">designbrnd.</span>
        </div>
        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon"
            className="w-7 h-7 text-stone-400 hover:text-white hover:bg-stone-800"
          >
            <Settings className="w-4 h-4" />
          </Button>
          <div className="relative">
            <Button
              variant="ghost"
              size="icon"
              className="w-7 h-7 text-stone-400 hover:text-white hover:bg-stone-800"
            >
              <div className="w-2 h-2" />
            </Button>
            <div className="absolute -top-1 -right-1 w-4 h-4 rounded-full bg-red-500 flex items-center justify-center text-[10px] font-medium text-white">
              1
            </div>
          </div>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="px-3 py-3 space-y-2">
        <Button
          className="w-full justify-start gap-2 bg-stone-800 hover:bg-stone-700 text-stone-200"
          size="sm"
        >
          <Plus className="w-4 h-4" />
          New
        </Button>

        <Button
          variant="ghost"
          className="w-full justify-start gap-2 text-stone-400 hover:text-white hover:bg-stone-800"
          size="sm"
        >
          <FolderOpen className="w-4 h-4" />
          <span className="flex-1 text-left">5</span>
        </Button>
      </div>

      {/* Current Project/Test Case */}
      <div className="px-3 py-2 border-b border-stone-800">
        <div className="flex items-center justify-between px-3 py-2 rounded bg-stone-800/50 hover:bg-stone-800 cursor-pointer group">
          <div className="flex items-center gap-2 min-w-0 flex-1">
            <FolderOpen className="w-4 h-4 text-cyan-400 shrink-0" />
            <span className="text-sm text-stone-200 truncate">{currentProject}</span>
          </div>
          <div className="flex items-center gap-1 shrink-0">
            <Button
              variant="ghost"
              size="icon"
              className="w-6 h-6 opacity-0 group-hover:opacity-100 text-stone-400 hover:text-white hover:bg-stone-700"
            >
              <div className="w-3 h-3 border border-current rounded" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="w-6 h-6 text-stone-400 hover:text-white hover:bg-stone-700"
            >
              <ChevronDown className="w-3 h-3" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="w-6 h-6 text-stone-400 hover:text-white hover:bg-stone-700"
            >
              <MoreVertical className="w-3 h-3" />
            </Button>
          </div>
        </div>
      </div>

      {/* Scrollable Content */}
      <div className="flex-1 overflow-y-auto">
        {/* PROJECT Section */}
        <div className="px-3 py-3">
          <div className="px-2 mb-2">
            <span className="text-xs font-medium text-stone-500 uppercase tracking-wider">
              Project
            </span>
          </div>
          <div className="space-y-1">
            {projectItems.map((item) => {
              const Icon = item.icon
              const active = isActive(item.path)
              return (
                <button
                  key={item.path}
                  onClick={() => navigate(item.path)}
                  className={cn(
                    "w-full flex items-center gap-3 px-3 py-2 rounded text-sm transition-colors group relative",
                    active
                      ? "bg-cyan-500/20 text-cyan-400"
                      : "text-stone-400 hover:text-white hover:bg-stone-800"
                  )}
                >
                  <Icon className="w-4 h-4 shrink-0" />
                  <span className="flex-1 text-left">{item.name}</span>
                  {active && (
                    <Button
                      variant="ghost"
                      size="icon"
                      className="w-5 h-5 text-cyan-400 hover:text-white hover:bg-cyan-500/30"
                      onClick={(e) => {
                        e.stopPropagation()
                      }}
                    >
                      <X className="w-3 h-3" />
                    </Button>
                  )}
                  {item.badge !== null && (
                    <div className="w-5 h-5 rounded-full bg-stone-700 flex items-center justify-center text-[10px] font-medium text-stone-400">
                      {item.badge}
                    </div>
                  )}
                </button>
              )
            })}
          </div>
        </div>

        {/* TOOLS Section */}
        <div className="px-3 py-3">
          <div className="px-2 mb-2">
            <span className="text-xs font-medium text-stone-500 uppercase tracking-wider">
              Tools
            </span>
          </div>
          <div className="space-y-1">
            {toolItems.map((item) => {
              const Icon = item.icon
              const active = isActive(item.path)
              return (
                <button
                  key={item.path}
                  onClick={() => navigate(item.path)}
                  className={cn(
                    "w-full flex items-center gap-3 px-3 py-2 rounded text-sm transition-colors",
                    active
                      ? "bg-stone-800 text-white"
                      : "text-stone-400 hover:text-white hover:bg-stone-800"
                  )}
                >
                  <Icon className="w-4 h-4 shrink-0" />
                  <span className="flex-1 text-left">{item.name}</span>
                  {item.badge !== null && (
                    <div className="w-5 h-5 rounded-full bg-stone-700 flex items-center justify-center text-[10px] font-medium text-stone-400">
                      {item.badge}
                    </div>
                  )}
                </button>
              )
            })}
          </div>
        </div>
      </div>

      {/* Bottom Section */}
      <div className="border-t border-stone-800 px-3 py-3 space-y-1">
        <button
          className="w-full flex items-center gap-3 px-3 py-2 rounded text-sm text-stone-400 hover:text-white hover:bg-stone-800 transition-colors"
        >
          <FolderOpen className="w-4 h-4 shrink-0" />
          <span className="flex-1 text-left">Wiki</span>
        </button>

        <button
          className="w-full flex items-center gap-3 px-3 py-2 rounded text-sm text-stone-400 hover:text-white hover:bg-stone-800 transition-colors"
        >
          <div className="w-4 h-4 shrink-0">
            <svg viewBox="0 0 16 16" className="w-4 h-4">
              <path
                fill="currentColor"
                d="M2 8a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm6 0a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm6 0a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"
              />
            </svg>
          </div>
          <span className="flex-1 text-left">Running Agents</span>
          <div className="w-5 h-5 rounded-full bg-cyan-500 flex items-center justify-center text-[10px] font-medium text-white">
            1
          </div>
        </button>

        <button
          onClick={() => navigate('/settings')}
          className={cn(
            "w-full flex items-center gap-3 px-3 py-2 rounded text-sm transition-colors",
            isActive('/settings')
              ? "bg-stone-800 text-white"
              : "text-stone-400 hover:text-white hover:bg-stone-800"
          )}
        >
          <Settings className="w-4 h-4 shrink-0" />
          <span className="flex-1 text-left">Settings</span>
        </button>
      </div>
    </aside>
  )
}
