﻿#pragma once

#include "stdafx.h"
#include <boost/fusion/include/adapt_struct.hpp>
#include <boost/variant.hpp>

using boost::variant;
using boost::make_recursive_variant;
using boost::recursive_variant_;
using boost::recursive_wrapper;

typedef
	make_recursive_variant<
		long,
		double,
		std::wstring,
		std::vector<recursive_variant_>
	>::type
Value;

struct Literal {
	Value value;
	Literal(std::vector<Value> v) : value(v) {};
	Literal(std::wstring v) : value(v) {};
	Literal(long v) : value(std::vector<Value>(1, v)) {};
	Literal(double v) : value(std::vector<Value>(1, v)) {};
	Literal() : value(std::vector<Value>()) {};
};

bool operator==(const Literal&, const Literal&);

BOOST_FUSION_ADAPT_STRUCT (
	Literal,
	(Value, value)
)

struct Variable {
	std::wstring name;
	Variable(std::wstring nm) : name(nm) {};
	Variable() : name(L"") {};
};

bool operator==(const Variable&, const Variable&);

BOOST_FUSION_ADAPT_STRUCT (
	Variable,
	(std::wstring, name)
)

typedef 
	make_recursive_variant<
		Variable,
		std::vector<recursive_variant_>
	>::type
VariableStrand;

enum FnPrimitive {
	PRIM_FN_PLUS,
	PRIM_FN_BANG,
	PRIM_FN_TIMES,
	PRIM_FN_DIVIDE,
	PRIM_FN_RHO,
	PRIM_FN_ENCLOSE,
	PRIM_FN_DISCLOSE,
	PRIM_FN_EQUAL,
	PRIM_FN_COMMA,
	PRIM_FN_IOTA,
	PRIM_FN_NABLA,
	PRIM_FN_MINUS,
	PRIM_FN_HOOK
};

enum OpPrimitive {
	PRIM_OP_INNER,
	PRIM_OP_OUTER,
	PRIM_OP_COMPOSE,
	PRIM_OP_COMMUTE,
	PRIM_OP_EACH, 
	PRIM_OP_POWER,
	PRIM_OP_REDUCE
};

struct MonadicApp;
struct DyadicApp;
struct VarAssignment;
struct StrandAssignment;
struct FnDef;
struct FnAssignment;
struct CondStatement;
struct IndexRef;
struct EmptyIndex;
struct MonadicOper;
struct DyadicOper;

typedef
	make_recursive_variant<
		Literal,
		Variable,
		recursive_wrapper<VarAssignment>,
		recursive_wrapper<StrandAssignment>,
		recursive_wrapper<MonadicApp>,
		recursive_wrapper<DyadicApp>,
		recursive_wrapper<IndexRef>,
		std::vector<recursive_variant_>
	>::type
Expression;

typedef
	variant<
		Expression,
		recursive_wrapper<EmptyIndex>
	>
IndexExpression;

typedef
	variant<
		Variable,
		FnPrimitive,
		recursive_wrapper<MonadicOper>,
		recursive_wrapper<DyadicOper>,
		recursive_wrapper<FnDef>
	>
FnValue;

typedef
	variant<
		Expression,
		FnPrimitive,
		recursive_wrapper<MonadicOper>,
		recursive_wrapper<DyadicOper>,
		recursive_wrapper<FnDef>
	>
FnOrValue;

typedef
	variant<
		Expression,
		recursive_wrapper<FnAssignment>,
		recursive_wrapper<CondStatement>
	>
Statement;

typedef
	variant<
		recursive_wrapper<VarAssignment>,
		recursive_wrapper<FnAssignment>,
		recursive_wrapper<StrandAssignment>
	>
Assignment;

struct EmptyIndex {
	EmptyIndex() {};
};

bool operator==(const EmptyIndex&, const EmptyIndex&);

struct CondStatement {
	Expression test;
	Statement statement;
	CondStatement(Expression t, Statement s) : test(t), statement(s) {};
	CondStatement() : test(Expression()), statement(Statement()) {};
};

bool operator==(const CondStatement&, const CondStatement&);

BOOST_FUSION_ADAPT_STRUCT (
	CondStatement,
	(Expression, test)
	(Statement, statement)
)

struct MonadicOper {
	FnValue left;
	OpPrimitive oper;
	MonadicOper(FnValue lft, OpPrimitive op) : left(lft), oper(op) {} ;
	MonadicOper() : left(FnValue()), oper(OpPrimitive()) {} ;
};

bool operator==(const MonadicOper&, const MonadicOper&);

BOOST_FUSION_ADAPT_STRUCT (
	MonadicOper,
	(FnValue, left)
	(OpPrimitive, oper)
)

struct DyadicOper {
	FnOrValue left;
	FnOrValue right;
	OpPrimitive oper;
	DyadicOper(FnOrValue lft, OpPrimitive op, FnOrValue rgt) : left(lft), oper(op), right(rgt) {} ;
	DyadicOper() : left(FnValue()), oper(OpPrimitive()), right(FnValue()) {} ;
};

bool operator==(const DyadicOper&, const DyadicOper&);

BOOST_FUSION_ADAPT_STRUCT (
	DyadicOper,
	(FnOrValue, left)
	(OpPrimitive, oper)
	(FnOrValue, right)
)

struct FnDef {
	std::vector<Statement> statements;
	FnDef(std::vector<Statement> es) : statements(es) {};
	FnDef() : statements(std::vector<Statement>()) {};
};

bool operator==(const FnDef&, const FnDef&);

BOOST_FUSION_ADAPT_STRUCT (
	FnDef,
	(std::vector<Statement>, statements)
)

struct MonadicApp {
	FnValue function;
	Expression right;
	MonadicApp(FnValue fn, Expression rgt) : function(fn), right(rgt) {};
	MonadicApp() : function(FnDef()), right(Literal()) {};
};

bool operator==(const MonadicApp&, const MonadicApp&);

BOOST_FUSION_ADAPT_STRUCT (
	MonadicApp,
	(FnValue, function)
	(Expression, right)
) 

struct DyadicApp {
	FnValue function;
	Expression right;
	Expression left;
	DyadicApp(Expression lft, FnValue fn, Expression rgt) : 
		function(fn), left(lft), right(rgt) {};
	DyadicApp() : function(FnDef()), left(Literal()), right(Literal()) {};
};

bool operator==(const DyadicApp&, const DyadicApp&);

BOOST_FUSION_ADAPT_STRUCT (
	DyadicApp,
	(Expression, left)
	(FnValue, function)
	(Expression, right)
)

struct IndexRef {
	Expression source;
	std::vector<IndexExpression> indexes;
	IndexRef(Expression s, std::vector<IndexExpression> i) : source(s), indexes(i) {};
	IndexRef() : source(Expression()), indexes(std::vector<IndexExpression>()) {};
};

bool operator==(const IndexRef&, const IndexRef&);

BOOST_FUSION_ADAPT_STRUCT (
	IndexRef,
	(Expression, source)
	(std::vector<IndexExpression>, indexes)
)

struct VarAssignment {
	Variable target;
	Expression expr;
	VarAssignment(Variable v, Expression e) : target(v), expr(e) {};
	VarAssignment() : target(Variable()), expr(Literal()) {};
};

bool operator==(const VarAssignment&, const VarAssignment&);

BOOST_FUSION_ADAPT_STRUCT (
	VarAssignment,
	(Variable, target)
	(Expression, expr)
) 

struct FnAssignment {
	Variable target;
	FnValue function;
	FnAssignment(Variable v, FnValue fn) : target(v), function(fn) {};
	FnAssignment() : target(Variable()), function(FnDef()) {};
};

bool operator==(const FnAssignment&, const FnAssignment&);

BOOST_FUSION_ADAPT_STRUCT (
	FnAssignment,
	(Variable, target)
	(FnValue, function)
) 

struct StrandAssignment {
	std::vector<VariableStrand> target;
	Expression expr;
	StrandAssignment(std::vector<VariableStrand> tgt, Expression e) : 
		target(tgt), expr(e) {};
	StrandAssignment() : target(std::vector<VariableStrand>()), expr(Literal()) {};
};

bool operator==(const StrandAssignment&, const StrandAssignment&);

BOOST_FUSION_ADAPT_STRUCT (
	StrandAssignment,
	(std::vector<VariableStrand>, target)
	(Expression, expr)
)

struct Module {
	std::vector<Assignment> definitions;
	Module(std::vector<Assignment> defs) : definitions(defs) {};
	Module() : definitions(std::vector<Assignment>()) {};
};

bool operator==(const Module&, const Module&);

BOOST_FUSION_ADAPT_STRUCT (
	Module,
	(std::vector<Assignment>, definitions)
)

struct ASTError {
	std::wstring message;
	ASTError(std::wstring msg) : message(msg) {};
};