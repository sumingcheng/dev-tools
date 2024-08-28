module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', // 新功能（feature）
        'fix', // 修复bug
        'docs', // 文档变更
        'style', // 代码格式变更（不影响功能，例如空格、分号等格式修正）
        'refactor', // 代码重构（不包括 bug 修复、功能新增）
        'perf', // 性能优化
        'test', // 添加、修改测试用例
        'build', // 构建流程、外部依赖变更（如升级 npm 包、修改 webpack 配置等）
        'ci', // 修改 CI 配置、脚本
        'chore', // 对构建过程或辅助工具和库的更改（不影响源文件、测试用例）
        'revert', // 回滚 commit
        'release', // 发布新版本
        'workflow', // 工作流程改进
        'types', // 类型定义文件修改
        'wip', // 开发中
        'deps', // 依赖变更
        'example', // 添加、修改示例代码
        'ui', // UI样式变更
        'init', // 初始化
        'typo', // 修复拼写错误
        'i18n', // 国际化与本地化
        'a11y', // 可访问性改进
        'metadata', // 修改元数据（比如 package.json）
        'lint', // 代码检查
      ],
    ],
    'type-case': [2, 'always', 'lower-case'], // type必须小写
    'type-empty': [2, 'never'], // type不能为空
    'scope-case': [2, 'always', 'lower-case'], // scope必须小写
    'subject-empty': [2, 'never'], // subject（简短描述）不能为空
    'subject-full-stop': [2, 'never', '.'], // subject结尾不能有句号
    'subject-case': [2, 'never', ['sentence-case', 'start-case', 'pascal-case', 'upper-case']], // subject必须小写
    'header-max-length': [2, 'always', 72], // header最大长度72个字符
    'body-leading-blank': [1, 'always'], // body前面必须有换行
    'footer-leading-blank': [1, 'always'], // footer前面必须有换行
    'references-empty': [2, 'never'], // 引用issues不能为空
  },
};
