<?php

namespace Bit3\FakerCli\Command;

use Faker\Factory;
use ReflectionMethod;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

class ListTypesCommand extends Command
{
    protected function configure()
    {
        $this
            ->setName('list-types')
            ->addOption(
                'locale',
                'l',
                InputOption::VALUE_REQUIRED,
                'The locale to use.',
                Factory::DEFAULT_LOCALE
            )->addArgument(
                'command',
                InputArgument::REQUIRED,
                'Command name'
            );
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $locale = $input->getOption('locale');
        $faker = Factory::create($locale);

        /** @var ReflectionMethod[] $help */
        $help = [];
        $providers = $faker->getProviders();
        foreach ($providers as $provider) {
            $a = new \ReflectionObject($provider);
            $methods = $a->getMethods(ReflectionMethod::IS_PUBLIC);
            foreach ($methods as $method) {
                if ($method->isPublic()) {
                    $help[$method->getName()] = $method;
                }
            }
        }

        $result = asort($help);
        if (false === $result) {
            throw new \RuntimeException('Can\'t sort types');
        }

        foreach ($help as $item) {
            $doc = $item->getName();
            foreach ($item->getParameters() as $parameter) {
                $doc .= ' ' . $parameter->getName();
            }

            $output->writeln($doc);
        }
    }
}