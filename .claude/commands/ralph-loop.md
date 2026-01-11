# RALPH LOOP - Test-Driven Development Workflow

## Overview

RALPH LOOP is a test-driven development workflow with visual verification for building Next.js applications with pixel-perfect accuracy.

## Workflow Steps

```
1. Write E2E Test → 2. Run Test (FAIL) → 3. Implement → 4. Run Test (PASS) →
5. Verify Screenshots → 6. Fix Issues → 7. Re-run → 8. Mark Verified → 9. Done
```

## Technology Stack

- **Next.js 14+** (App Router)
- **React 19+**
- **Playwright** for E2E testing
- **shadcn/ui** component library
- **Tailwind CSS**

## Step-by-Step Guide

### Step 1: Write E2E Test

Create a test file encoding the Figma design specifications:

```typescript
// e2e/feature-name.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Feature Name', () => {
  test('should display correctly', async ({ page }) => {
    await page.goto('/');

    // Test element presence
    const element = page.getByTestId('feature-element');
    await expect(element).toBeVisible();

    // Test exact text from approved design
    const headline = page.getByTestId('feature-headline');
    await expect(headline).toContainText('Exact Text from Figma');

    // Test exact color from design tokens
    const button = page.getByTestId('feature-cta');
    await expect(button).toHaveCSS('background-color', 'rgb(220, 38, 38)');

    // Visual regression test
    await page.screenshot({
      path: 'e2e/screenshots/feature-name/desktop-view.png',
      fullPage: false
    });
  });
});
```

### Step 2: Run Test (Expected FAIL)

```bash
pnpm test e2e/feature-name.spec.ts
# Expected: FAIL - no components implemented yet
```

### Step 3: Implement Components

Create the components using shadcn/ui and design tokens:

```typescript
// components/feature-element.tsx
import { Button } from '@/components/ui/button';

export function FeatureElement() {
  return (
    <section
      data-testid="feature-element"
      className="h-[800px] bg-cover"
    >
      <h1 data-testid="feature-headline">
        Exact Text from Figma
      </h1>
      <Button
        data-testid="feature-cta"
        className="bg-primary-red"
      >
        Call to Action
      </Button>
    </section>
  );
}
```

### Step 4: Run Test (Should PASS)

```bash
pnpm test e2e/feature-name.spec.ts
# Expected: PASS - all assertions pass
# Screenshots generated in e2e/screenshots/feature-name/
```

### Step 5: Visual Verification

Review screenshots against Figma designs:

- Check text is visible and positioned correctly
- Verify colors match design tokens
- Ensure spacing and layout match Figma
- Test responsive behavior
- Check for visual bugs (overflow, clipping, etc.)

### Step 6: Fix Issues

If visual issues found, fix them and re-run tests.

### Step 7: Mark Verified

Once all issues are resolved and screenshots match Figma:

```bash
mv e2e/screenshots/feature-name/desktop-view.png \
   e2e/screenshots/feature-name/verified_desktop-view.png

mv e2e/screenshots/feature-name/mobile-view.png \
   e2e/screenshots/feature-name/verified_mobile-view.png
```

### Step 8: Confirm Completion

All screenshot files should have the `verified_` prefix:

```bash
ls e2e/screenshots/feature-name/
# verified_desktop-view.png
# verified_mobile-view.png
```

### Step 9: Output Promise

```
<promise>FEATURE_NAME_DONE</promise>
```

## Integration with Design OS

Use Design OS outputs in your tests:

```typescript
// Use sample data from Design OS
import sampleData from '../product/sections/homepage/data.json';

// Use design tokens
import designTokens from '../product/design-system/colors.json';
```

## Playwright Configuration

```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './e2e',
  use: {
    baseURL: 'http://localhost:3000',
    screenshot: 'only-on-failure',
  },
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

## Quality Gates

- ✅ All tests must pass
- ✅ Screenshots must be verified against Figma
- ✅ Both desktop and mobile views tested
- ✅ All screenshots prefixed with `verified_`
- ✅ No visual regressions introduced

## Tips

- Always add `data-testid` attributes to testable elements
- Use exact colors from design tokens (convert hex to rgb for CSS testing)
- Test both desktop (1440px) and mobile (375px) viewports
- Run with UI mode for debugging: `npx playwright test --ui`

---

**Time Savings:** 30-40 hours per project vs. manual QA
**Quality Improvement:** Catches 90% of visual bugs before client review
