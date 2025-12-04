Help us make Sage.is AI-UI available to a wider audience. We use [Weblate](https://weblate.org/en/), a web-based translation tool with tight version control integration to manage translations. In this section, we'll guide you through the process of adding new translations to Sage.is AI-UI.

translations of Sage.is AI-UI in Weblate are organized into projects and components. Each project can contain number of components and those contain translations into individual languages. The component corresponds to one translatable file (for example [Android string resources](https://docs.weblate.org/en/latest/formats/android.html#aresource)). The projects are there to help you organize component into logical sets (for example to group all translations used within one application).

Additionally, components within projects are structured using categories. Components can belong to a category, and categories can be nested.

Internally, each project has translations to common strings propagated across other components within it by default. This lightens the burden of repetitive and multi version translation. The translation propagation can be disabled per [Component configuration](https://docs.weblate.org/en/latest/admin/projects.html#component) using [Allow translation propagation](https://docs.weblate.org/en/latest/admin/projects.html#component-allow-translation-propagation) in case the translations should diverge.

## Repository integration

Sage.is Weblate translation is built to integrate with upstream version control repository, [Continuous localization](https://docs.weblate.org/en/latest/admin/continuous.html) describes building blocks and how the changes flow between them. You don't have to worry about the technicals, we'll handle that for you.

## User attribution

Once you create a Sage.is AI-UI translation account we'll keep the translations properly authored by you and other translators in the version control repository by using name and e-mail. Having a real e-mail attached to the commit follows the distributed version control spirits and allows services like GitHub to associate your contributions done in Weblate with your GitHub profile.

This feature also brings in risk of misusing e-mail published in the version control commits. Moreover, once such a commit is published on public hosting (such as GitHub), there is effectively no way to redact it. Weblate allows choosing a private commit e-mail in [Account](https://docs.weblate.org/en/latest/user/profile.html#profile-account) to avoid this.

Therefore, admins should consider this while configuring Weblate:

- Such a usage of e-mail should be clearly described in service terms in case such document is needed. [Legal module](https://docs.weblate.org/en/latest/admin/optionals.html#legal) can help with that.
    
- [`PRIVATE_COMMIT_EMAIL_OPT_IN`](https://docs.weblate.org/en/latest/admin/config.html#std-setting-PRIVATE_COMMIT_EMAIL_OPT_IN) can make e-mails private by default.